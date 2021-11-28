# frozen_string_literal: true

class ShippingDetailsRepository
  def initialize(relation: ShippingDetail)
    @relation = relation
  end

  def create(shipping_information)
    relation.create!(**shipping_information.to_h)
  end

  private

  attr_reader :relation
end
