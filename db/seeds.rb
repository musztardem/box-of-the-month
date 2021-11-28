# frozen_string_literal: true

subscription_plans = [
  {
    name: 'Bronze Box',
    price: 1999
  },
  {
    name: 'Silver Box',
    price: 4900
  },
  {
    name: 'Gold Box',
    price: 9900
  }
]

subscription_plans.each { |sp| SubscriptionPlan.create!(sp) }
