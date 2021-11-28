# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    id { Faker::Number.number(digits: 3) }
  end
end
