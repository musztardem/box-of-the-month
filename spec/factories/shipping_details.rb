# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_detail do
    first_name { 'MyString' }
    last_name { 'MyString' }
    address { 'MyString' }
    zip_code { 'MyString' }
    customers_subscription { nil }
  end
end
