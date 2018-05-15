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

ActiveRecord::Schema.define(version: 20180510135703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "identities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.jsonb "info", default: {}, null: false
    t.jsonb "credentials", default: {}, null: false
    t.jsonb "extra", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true
    t.index ["provider", "user_id"], name: "index_identities_on_provider_and_user_id", unique: true
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "maps", force: :cascade do |t|
    t.string "summary_polyline"
    t.string "polyline"
    t.string "strava_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "routes_id"
    t.index ["routes_id"], name: "index_maps_on_routes_id"
    t.index ["strava_id"], name: "index_maps_on_strava_id"
  end

  create_table "routes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "distance"
    t.float "elevation_gain"
    t.integer "sub_type"
    t.integer "strava_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["strava_id"], name: "index_routes_on_strava_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "auth_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_token"], name: "index_users_on_auth_token"
  end

  add_foreign_key "identities", "users"
  add_foreign_key "maps", "routes", column: "routes_id"
end
