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

ActiveRecord::Schema.define(version: 20160302195118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "state"
    t.string   "country"
    t.string   "type"
    t.string   "subtype"
    t.text     "body_text"
    t.text     "details"
    t.string   "url"
    t.text     "categories"
    t.text     "tags"
    t.string   "phone_number"
    t.boolean  "family_friendly"
    t.datetime "dstart"
    t.datetime "dtend"
    t.integer  "duration"
    t.datetime "ticket_deadline"
    t.boolean  "tickets_required"
    t.float    "price"
    t.boolean  "free"
    t.string   "contact_name"
    t.integer  "organizer_id"
    t.integer  "venue_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "timezone"
    t.string   "image_url"
    t.string   "ticketing_url"
    t.string   "uid"
    t.string   "fb_event_url"
    t.string   "city"
    t.string   "postal_code"
    t.string   "address"
    t.string   "name"
    t.integer  "status"
    t.text     "log"
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "success"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_number"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "postal_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token",             default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_number"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "postal_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
  end

end
