# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_28_140659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers_subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "subscription_plan_id", null: false
    t.date "last_successful_payment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_customers_subscriptions_on_customer_id"
    t.index ["subscription_plan_id"], name: "index_customers_subscriptions_on_subscription_plan_id"
  end

  create_table "payment_details", force: :cascade do |t|
    t.string "token"
    t.bigint "customers_subscription_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customers_subscription_id"], name: "index_payment_details_on_customers_subscription_id"
  end

  create_table "shipping_details", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "zip_code"
    t.bigint "customers_subscription_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customers_subscription_id"], name: "index_shipping_details_on_customers_subscription_id"
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "customers_subscriptions", "customers"
  add_foreign_key "customers_subscriptions", "subscription_plans"
  add_foreign_key "payment_details", "customers_subscriptions"
  add_foreign_key "shipping_details", "customers_subscriptions"
end
