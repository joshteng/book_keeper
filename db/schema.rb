# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140810143333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "book_users", force: true do |t|
    t.uuid     "book_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_users", ["book_id", "user_id"], name: "index_book_users_on_book_id_and_user_id", unique: true, using: :btree

  create_table "books", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "entry",                                      null: false
    t.string   "item",                                       null: false
    t.text     "notes"
    t.decimal  "amount",             precision: 8, scale: 2, null: false
    t.string   "currency",                                   null: false
    t.date     "transacted_at",                              null: false
    t.string   "transaction_method",                         null: false
    t.string   "receipt_url"
    t.integer  "user_id"
    t.uuid     "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["book_id"], name: "index_transactions_on_book_id", using: :btree
  add_index "transactions", ["entry"], name: "index_transactions_on_entry", using: :btree
  add_index "transactions", ["transaction_method"], name: "index_transactions_on_transaction_method", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
