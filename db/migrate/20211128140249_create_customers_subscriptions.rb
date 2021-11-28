class CreateCustomersSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :customers_subscriptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :subscription_plan, null: false, foreign_key: true
      t.date :last_successful_payment_date

      t.timestamps
    end
  end
end
