# frozen_string_literal: true

class PaymentDetail < ApplicationRecord
  belongs_to :customers_subscription
end
