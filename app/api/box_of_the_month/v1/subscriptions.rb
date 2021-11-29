# frozen_string_literal: true

module BoxOfTheMonth
  module V1
    class Subscriptions < Grape::API
      version 'v1', using: :path
      prefix :api

      resource :subscriptions do
        params do
          requires :customer_id, type: Integer, allow_blank: false
          requires :shipping_information, type: Hash do
            requires :first_name, type: String, allow_blank: false
            requires :last_name, type: String, allow_blank: false
            requires :address, type: String, allow_blank: false
            requires :zip_code, type: String, allow_blank: false
          end
          requires :billing_information, type: Hash do
            requires :card_number, type: String, allow_blank: false
            requires :expiration_month, type: String, allow_blank: false
            requires :expiration_year, type: String, allow_blank: false
            requires :cvv, type: String, allow_blank: false
            requires :zip_code, type: String, allow_blank: false
          end
          requires :subscription_plan_id, type: Integer, allow_blank: false
        end
        post do
          shipping_information = ShippingInformationValue.new(params[:shipping_information])
          billing_information = BillingInformationValue.new(params[:billing_information])

          ::Subscriptions::Create.new.call(
            customer_id: params[:customer_id],
            shipping_information: shipping_information,
            billing_information: billing_information,
            subscription_plan_id: params[:subscription_plan_id]
          ) do |result|
            result.success { status :created }
            result.failure(:not_found) do |_code, model|
              error!({ message: "#{model} does not exist" }, :not_found)
            end
            result.failure(:payment_failed) do |_code, msg|
              error!({ message: msg }, :unprocessable_entity)
            end
            result.failure { status :service_unavailable }
          end
        end
      end
    end
  end
end
