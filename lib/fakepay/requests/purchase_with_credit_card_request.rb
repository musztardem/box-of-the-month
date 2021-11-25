# frozen_string_literal: true

require 'dry/validation'

module Fakepay
  module Requests
    class PurchaseWithCreditCardRequest < Dry::Validation::Contract
      params do
        required(:amount).filled(:string)
        required(:card_number).filled(:string)
        required(:cvv).filled(:string)
        required(:expiration_month).filled(:string)
        required(:expiration_year).filled(:string)
        required(:zip_code).filled(:string)
      end
    end
  end
end
