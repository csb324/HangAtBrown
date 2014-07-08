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

ActiveRecord::Schema.define(version: 20140708231031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.integer  "location_id"
    t.datetime "start_time",  null: false
    t.datetime "end_time",    null: false
    t.text     "topic"
    t.string   "event_type"
  end

  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree

  create_table "locations", force: true do |t|
    t.text "name",        null: false
    t.text "description", null: false
    t.text "url",         null: false
  end

  create_table "rsvps", force: true do |t|
    t.integer  "user_id",                          null: false
    t.integer  "event_id",                         null: false
    t.datetime "expected_arrival",                 null: false
    t.text     "outfit",                           null: false
    t.boolean  "creator",          default: false
  end

  add_index "rsvps", ["event_id"], name: "index_rsvps_on_event_id", using: :btree
  add_index "rsvps", ["user_id"], name: "index_rsvps_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",          null: false
    t.string   "encrypted_password",     default: "",          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "first_name",                                   null: false
    t.text     "last_name",                                    null: false
    t.string   "phone_number",                                 null: false
    t.text     "class_year",                                   null: false
    t.text     "concentration",          default: "Undecided", null: false
    t.text     "interest_one"
    t.text     "interest_two"
    t.text     "interest_three"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
