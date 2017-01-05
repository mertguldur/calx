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

ActiveRecord::Schema.define(version: 20170105152653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_authorization_requests", force: :cascade do |t|
    t.integer  "tenant_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_app_authorization_requests_on_tenant_id", using: :btree
    t.index ["user_id"], name: "index_app_authorization_requests_on_user_id", using: :btree
  end

  create_table "app_authorization_response_types", force: :cascade do |t|
    t.text "app_authorization_response_type"
  end

  create_table "app_authorization_responses", force: :cascade do |t|
    t.integer  "app_authorization_request_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "app_authorization_response_type_id"
    t.index ["app_authorization_request_id"], name: "index_app_authorization_request_id", using: :btree
    t.index ["app_authorization_response_type_id"], name: "app_authorization_response_type_id", using: :btree
  end

  create_table "event_types", force: :cascade do |t|
    t.text "event_type"
  end

  create_table "events", force: :cascade do |t|
    t.text     "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "notes"
    t.integer  "user_id"
    t.integer  "event_type_id"
    t.index ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "tenants", force: :cascade do |t|
    t.text     "access_id"
    t.text     "secret_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_zones", force: :cascade do |t|
    t.text "time_zone"
  end

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "remember_digest"
    t.integer  "time_zone_id"
    t.text     "api_id",          null: false
    t.index ["api_id"], name: "index_users_on_api_id", unique: true, using: :btree
    t.index ["time_zone_id"], name: "index_users_on_time_zone_id", using: :btree
  end

  add_foreign_key "app_authorization_requests", "tenants"
  add_foreign_key "app_authorization_requests", "users"
  add_foreign_key "app_authorization_responses", "app_authorization_requests"
  add_foreign_key "app_authorization_responses", "app_authorization_response_types"
  add_foreign_key "events", "event_types"
  add_foreign_key "events", "users"
  add_foreign_key "users", "time_zones"
end
