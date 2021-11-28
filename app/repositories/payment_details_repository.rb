# frozen_string_literal: true

class PaymentDetailsRepository
  def initialize(relation: PaymentDetail)
    @relation = relation
  end

  def create(customers_subscription_id:, token:)
    relation.create!(customers_subscription_id: customers_subscription_id, token: token)
  end

  private

  attr_reader :relation
end
