class CreateSubscriptionPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_plans do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
