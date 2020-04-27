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

ActiveRecord::Schema.define(version: 2020_04_04_172611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "realtor_profile_id"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "street"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["realtor_profile_id"], name: "index_addresses_on_realtor_profile_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "order_type"
    t.text "description"
    t.string "email"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "realtor_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tel"
    t.text "bio"
    t.string "email"
    t.index ["user_id"], name: "index_realtor_profiles_on_user_id"
  end

  create_table "realtor_ratings", force: :cascade do |t|
    t.integer "value"
    t.integer "client_id"
    t.integer "realtor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "realtor_id"], name: "index_realtor_ratings_on_client_id_and_realtor_id", unique: true
    t.index ["client_id"], name: "index_realtor_ratings_on_client_id"
    t.index ["realtor_id"], name: "index_realtor_ratings_on_realtor_id"
  end

  create_table "responded_or_sent_orders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "realtor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id", "realtor_id"], name: "index_responded_or_sent_orders_on_order_id_and_realtor_id", unique: true
    t.index ["order_id"], name: "index_responded_or_sent_orders_on_order_id"
    t.index ["realtor_id"], name: "index_responded_or_sent_orders_on_realtor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.string "remember_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "realtor_profiles"
  add_foreign_key "orders", "users"
  add_foreign_key "realtor_profiles", "users"
end
