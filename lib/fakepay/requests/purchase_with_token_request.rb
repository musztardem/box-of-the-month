# frozen_string_literal: true

module Fakepay
  module Requests
    class PurchaseWithTokenRequest < Dry::Validation::Contract
      params do
        required(:token).filled(:string)
        required(:amount).filled(:string)
      end
    end
  end
end
