# frozen_string_literal: true

FactoryBot.define do
  factory :customers_subscription do
    customer { nil }
    subscription_plan { nil }
    last_successful_payment_date { '2021-11-28' }
  end
end
