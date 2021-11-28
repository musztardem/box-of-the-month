# frozen_string_literal: true

class ShippingInformationValue < Dry::Struct
  transform_keys(&:to_sym)

  attribute :first_name, Types::Strict::String
  attribute :last_name, Types::Strict::String
  attribute :address, Types::Strict::String
  attribute :zip_code, Types::Strict::String
end
