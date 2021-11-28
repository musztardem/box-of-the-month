# frozen_string_literal: true

class CustomersRepository
  def initialize(relation: Customer)
    @relation = relation
  end

  delegate :exists?, to: :relation

  private

  attr_reader :relation
end
