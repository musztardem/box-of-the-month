# frozen_string_literal: true

class SubscriptionPlansRepository
  def initialize(relation: SubscriptionPlan)
    @relation = relation
  end

  delegate :exists?, to: :relation

  def get_price_for(id:)
    relation.find_by(id: id).price
  end

  private

  attr_reader :relation
end
