# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :customers_subscriptions, dependent: :destroy
end
