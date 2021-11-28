# frozen_string_literal: true

class CustomerSubscriptionsRepository
  def initialize(relation: CustomersSubscription)
    @relation = relation
  end

  def load(id:)
    relation.find(id)
  end

  def create(customer_id:, subscription_plan_id:, last_successful_payment_date: nil)
    relation.create!(customer_id: customer_id, subscription_plan_id: subscription_plan_id,
                     last_successful_payment_date: last_successful_payment_date).id
  end

  def set_last_successful_payment_date(customers_subscription_id:, date:)
    load(id: customers_subscription_id)
      .update!(id: customers_subscription_id, last_successful_payment_date: date)
  end

  private

  attr_reader :relation
end
