class CreatePaymentDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_details do |t|
      t.string :token
      t.references :customers_subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
