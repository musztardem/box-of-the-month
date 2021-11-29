# frozen_string_literal: true

require 'dry/matcher/result_matcher'
require 'fakepay/client'

module Subscriptions
  class Create
    include Dry::Monads[:result, :do]
    include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

    def initialize(customers_repo: CustomersRepository.new,
                   subscription_plans_repo: SubscriptionPlansRepository.new,
                   customer_subscriptions_repo: CustomerSubscriptionsRepository.new,
                   shipping_details_repo: ShippingDetailsRepository.new,
                   payment_details_repo: PaymentDetailsRepository.new,
                   fakepay_client: Fakepay::Client.new(api_key:
                    Rails.configuration.x.fakepay_api_key))
      @customers_repo = customers_repo
      @subscription_plans_repo = subscription_plans_repo
      @customer_subscriptions_repo = customer_subscriptions_repo
      @shipping_details_repo = shipping_details_repo
      @payment_details_repo = payment_details_repo
      @fakepay_client = fakepay_client
    end

    def call(customer_id:, shipping_information:, billing_information:, subscription_plan_id:)
      ActiveRecord::Base.transaction do
        yield verify_customer_existence(customer_id)
        price = yield load_subscription_plan_price(subscription_plan_id)
        subscription = yield create_customers_subscription(customer_id, subscription_plan_id)
        yield create_shipping_details(shipping_information, subscription)
        token = yield perform_payment(billing_information, price)
        yield create_payment_details(token, subscription)

        Success(nil)
      end
    end

    private

    def verify_customer_existence(customer_id)
      return Success(nil) if customers_repo.exists?(id: customer_id)

      Failure([:not_found, 'Customer'])
    end

    def create_customers_subscription(customer_id, subscription_plan_id)
      Success(customer_subscriptions_repo.create(customer_id: customer_id,
                                                 subscription_plan_id: subscription_plan_id,
                                                 last_successful_payment_date: Date.current))
    end

    def create_shipping_details(shipping_information, subscription)
      Success(shipping_details_repo.create(
                **shipping_information.to_h.merge(customers_subscription_id: subscription.id)
              ))
    end

    def load_subscription_plan_price(subscription_plan_id)
      return Failure([:not_found, 'Subscription Plan']) unless subscription_plans_repo
                                                               .exists?(id: subscription_plan_id)

      Success(subscription_plans_repo.get_price_for(id: subscription_plan_id))
    end

    def perform_payment(billing_information, price)
      params = billing_information.to_h.merge(amount: price.to_s)
      result = fakepay_client.purchase_with_credit_card(params: params)

      return Success(result.token) if result.success?

      Failure([:payment_failed, result.error])
    end

    def create_payment_details(token, subscription)
      payment_details_repo.create(customers_subscription_id: subscription.id, token: token)

      Success(nil)
    end

    attr_reader :customers_repo, :subscription_plans_repo, :customer_subscriptions_repo,
                :shipping_details_repo, :payment_details_repo, :fakepay_client
  end
end
