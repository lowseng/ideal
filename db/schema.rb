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

ActiveRecord::Schema.define(version: 20160921083823) do

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "areas", ["region_id"], name: "index_areas_on_region_id"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "proptype"
    t.text     "category"
    t.text     "place"
    t.text     "region"
    t.text     "area"
    t.integer  "bathroom"
    t.integer  "bedroom"
    t.decimal  "size",        precision: 10, scale: 2
    t.decimal  "amount",      precision: 10, scale: 2
    t.text     "uom"
    t.text     "currency"
    t.boolean  "xpool",                                default: false
    t.boolean  "xsqua",                                default: false
    t.boolean  "xplay",                                default: false
    t.boolean  "xbalc",                                default: false
    t.boolean  "xgymn",                                default: false
    t.boolean  "xmini",                                default: false
    t.boolean  "xjogg",                                default: false
    t.boolean  "xcabl",                                default: false
    t.boolean  "xtenn",                                default: false
    t.boolean  "xpark",                                default: false
    t.boolean  "xsecu",                                default: false
    t.boolean  "xlift",                                default: false
    t.text     "otherinfo"
    t.decimal  "size1",       precision: 10, scale: 2
    t.text     "titletype"
    t.boolean  "xonline",                              default: true
  end

  create_table "card_transactions", force: :cascade do |t|
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "card_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "cards", ["user_id"], name: "index_cards_on_user_id"

  create_table "chainas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chainbs", force: :cascade do |t|
    t.string   "name"
    t.integer  "chaina_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chainbs", ["chaina_id"], name: "index_chainbs_on_chaina_id"

  create_table "chaincs", force: :cascade do |t|
    t.string   "name"
    t.integer  "chainb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chaincs", ["chainb_id"], name: "index_chaincs_on_chainb_id"

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "picture"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["article_id"], name: "index_images_on_article_id"

  create_table "otherinfos", force: :cascade do |t|
    t.string   "name"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "otherinfos", ["place_id"], name: "index_otherinfos_on_place_id"

  create_table "payments", force: :cascade do |t|
    t.string   "email"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paypals", force: :cascade do |t|
    t.string   "item_number"
    t.string   "invoice"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "m_id"
    t.string   "quantity"
    t.string   "item_name"
    t.string   "mc_currency"
    t.string   "mc_gross"
    t.string   "mc_fee"
    t.string   "payment_gross"
    t.string   "handling_amount"
    t.string   "shipping"
    t.string   "tax"
    t.string   "payment_status"
    t.string   "payment_type"
    t.string   "payment_date"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_name"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address_country"
    t.string   "address_country_code"
    t.string   "payer_id"
    t.string   "payer_email"
    t.string   "payer_status"
    t.string   "business"
    t.string   "receiver_email"
    t.string   "receiver_id"
    t.string   "payment_fee"
    t.string   "txn_id"
    t.string   "txn_type"
    t.string   "residence_country"
    t.integer  "user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",     default: false
    t.text     "currency"
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["place_id"], name: "index_regions_on_place_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.text     "name"
    t.text     "telephone"
    t.text     "agentno"
    t.text     "company"
    t.text     "preferuom"
    t.text     "prefercountry"
    t.boolean  "gold",                   default: false
    t.text     "notification_params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "purchased_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
