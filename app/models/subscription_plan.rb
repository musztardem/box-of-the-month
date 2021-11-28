# frozen_string_literal: true

class SubscriptionPlan < ApplicationRecord
  has_many :customers_subscriptions, dependent: :destroy
end
