class CreateShippingDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_details do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :zip_code
      t.references :customers_subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
