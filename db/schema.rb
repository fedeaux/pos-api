# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161001145738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consumptions", force: :cascade do |t|
    t.string   "state"
    t.decimal  "total_price",    precision: 10, scale: 2, default: "0.0"
    t.decimal  "payed_value",    precision: 10, scale: 2, default: "0.0"
    t.decimal  "discount_value", precision: 10, scale: 2, default: "0.0"
    t.decimal  "tip_value",      precision: 10, scale: 2, default: "0.0"
    t.integer  "table_id"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.index ["table_id"], name: "index_consumptions_on_table_id", using: :btree
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_consumptions", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "consumption_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["consumption_id"], name: "index_product_consumptions_on_consumption_id", using: :btree
    t.index ["product_id"], name: "index_product_consumptions_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "price",       precision: 10, scale: 2, default: "0.0"
    t.boolean  "active",                               default: true
    t.integer  "category_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "initialized", default: false
  end

  create_table "tables", force: :cascade do |t|
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "role"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "waiters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "consumptions", "tables"
  add_foreign_key "product_consumptions", "consumptions"
  add_foreign_key "product_consumptions", "products"
end
