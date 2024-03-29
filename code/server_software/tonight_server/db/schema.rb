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

ActiveRecord::Schema.define(version: 20140321144641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "events_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_events", id: false, force: true do |t|
    t.integer "category_id", null: false
    t.integer "event_id",    null: false
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "events_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "venue_id"
    t.integer  "ref_id",        limit: 8
    t.string   "name"
    t.text     "desc"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "timezone"
    t.integer  "venue"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "city_id"
    t.integer  "categories_id"
    t.string   "cover_photo"
  end

  create_table "events_users", id: false, force: true do |t|
    t.integer "user_id",  null: false
    t.integer "event_id", null: false
  end

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "api"
    t.string   "filters"
    t.string   "toe"
    t.string   "output"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed"
  end

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "enc_password"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
  end

  create_table "venues", force: true do |t|
    t.integer  "ref_id",     limit: 8
    t.string   "about"
    t.text     "desc"
    t.string   "street"
    t.integer  "city_id"
    t.string   "county"
    t.string   "country"
    t.string   "post_code"
    t.integer  "lat"
    t.integer  "lon"
    t.string   "phone"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

end
