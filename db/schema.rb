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

ActiveRecord::Schema.define(version: 20170111141903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_authorization_requests", force: :cascade do |t|
    t.integer  "tenant_id",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_app_authorization_requests_on_tenant_id", using: :btree
    t.index ["user_id"], name: "index_app_authorization_requests_on_user_id", using: :btree
  end

  create_table "app_authorization_response_types", force: :cascade do |t|
    t.text "app_authorization_response_type", null: false
    t.index ["app_authorization_response_type"], name: "index_response_types_on_app_authorization_response_type", unique: true, using: :btree
  end

  create_table "app_authorization_responses", force: :cascade do |t|
    t.integer  "app_authorization_request_id",       null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "app_authorization_response_type_id", null: false
    t.index ["app_authorization_request_id"], name: "index_app_authorization_request_id", using: :btree
    t.index ["app_authorization_response_type_id"], name: "app_authorization_response_type_id", using: :btree
  end

  create_table "event_types", force: :cascade do |t|
    t.text "event_type", null: false
    t.index ["event_type"], name: "index_event_types_on_event_type", unique: true, using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",         limit: 500,   null: false
    t.datetime "start_time",                  null: false
    t.datetime "end_time",                    null: false
    t.string   "notes",         limit: 10000
    t.integer  "user_id",                     null: false
    t.integer  "event_type_id",               null: false
    t.index ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
    t.index ["start_time"], name: "index_events_on_start_time", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "tenants", force: :cascade do |t|
    t.string   "access_id",  limit: 500, null: false
    t.text     "secret_key",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["access_id"], name: "index_tenants_on_access_id", unique: true, using: :btree
  end

  create_table "time_zones", force: :cascade do |t|
    t.text "time_zone", null: false
    t.index ["time_zone"], name: "index_time_zones_on_time_zone", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 500, null: false
    t.text     "password_digest",             null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "remember_digest",             null: false
    t.integer  "time_zone_id",                null: false
    t.text     "api_id",                      null: false
    t.index ["api_id"], name: "index_users_on_api_id", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_digest"], name: "index_users_on_remember_digest", unique: true, using: :btree
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
