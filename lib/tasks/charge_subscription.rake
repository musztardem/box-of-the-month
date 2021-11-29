# frozen_string_literal: true

require 'fakepay/client'

namespace :subscriptions do
  desc 'Charges subscriptions that have not been charged this month yet'
  task charge: :environment do
    CustomersSubscription
      .where('last_successful_payment_date <= ?', 1.month.ago)
      .includes(:subscription_plan, :payment_detail).each do |subscription|
        price = subscription.subscription_plan.price
        token = subscription.payment_detail.token

        client = Fakepay::Client.new(api_key: Rails.configuration.x.fakepay_api_key)
        result = client.purchase_with_token(params: { token: token, amount: price.to_s })

        subscription.update!(last_successful_payment_date: Date.current) if result.success?
      end
  end
end
