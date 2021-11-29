# frozen_string_literal: true

class CustomerSubscriptionsRepository
  def initialize(relation: CustomersSubscription)
    @relation = relation
  end

  def create(customer_id:, subscription_plan_id:, last_successful_payment_date: nil)
    relation.create!(customer_id: customer_id, subscription_plan_id: subscription_plan_id,
                     last_successful_payment_date: last_successful_payment_date)
  end

  private

  attr_reader :relation
end
