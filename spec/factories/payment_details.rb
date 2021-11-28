# frozen_string_literal: true

FactoryBot.define do
  factory :payment_detail do
    token { 'MyString' }
    customers_subscription { nil }
  end
end
