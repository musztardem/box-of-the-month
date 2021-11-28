# frozen_string_literal: true

class CustomersSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription_plan

  has_one :shipping_detail, dependent: :destroy
  has_one :payment_detail, dependent: :destroy
end
