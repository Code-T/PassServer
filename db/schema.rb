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

ActiveRecord::Schema.define(version: 20160516160124) do

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passes", force: :cascade do |t|
    t.string   "serial_number"
    t.string   "authentication_token"
    t.string   "barcode_message"
    t.string   "user_name"
    t.string   "user_phone_number"
    t.string   "user_type"
    t.string   "real_name"
    t.string   "company_name"
    t.string   "github_id"
    t.string   "mail"
    t.integer  "salon_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "passes", ["salon_id"], name: "index_passes_on_salon_id"

  create_table "salons", force: :cascade do |t|
    t.string   "name"
    t.string   "topic"
    t.string   "detail_location"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "time"
    t.string   "foreground_color"
    t.string   "background_color"
    t.string   "iBeacon"
    t.text     "detail_info"
    t.text     "guests"
    t.text     "help"
    t.text     "about"
    t.integer  "location_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "salons", ["location_id"], name: "index_salons_on_location_id"

end
