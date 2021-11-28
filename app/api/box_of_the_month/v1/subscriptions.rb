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
            requires :billing_zip_code, type: String, allow_blank: false
          end
          requires :subscription_plan_id, type: Integer, allow_blank: false
        end
        post do
          ::Subscriptions::Create.new.call do |result|
            result.success { status :created }
            result.failure { status :service_unavailable }
          end
        end
      end
    end
  end
end
