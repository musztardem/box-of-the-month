# frozen_string_literal: true

class ShippingDetail < ApplicationRecord
  belongs_to :customers_subscription
end
