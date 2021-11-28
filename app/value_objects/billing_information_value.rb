# frozen_string_literal: true

class BillingInformationValue < Dry::Struct
  transform_keys(&:to_sym)

  attribute :card_number, Types::Strict::String
  attribute :expiration_month, Types::Strict::String
  attribute :expiration_year, Types::Strict::String
  attribute :cvv, Types::Strict::String
  attribute :zip_code, Types::Strict::String
end
