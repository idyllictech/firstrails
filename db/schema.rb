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

ActiveRecord::Schema.define(version: 2020_06_30_155708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "first_name", limit: 150
    t.string "last_name", limit: 150
    t.string "email", limit: 150, default: "a", null: false
    t.string "hashed_password", limit: 250
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", limit: 150
    t.string "salt", limit: 50
    t.index ["username"], name: "index_admin_users_on_username"
  end

  create_table "admin_users_pages", id: false, force: :cascade do |t|
    t.integer "admin_user_id", default: 0
    t.integer "page_id", default: 0
    t.index ["admin_user_id", "page_id"], name: "index_admin_users_pages_on_admin_user_id_and_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "permalink", limit: 250, default: "a", null: false
    t.integer "position", default: 0
    t.boolean "visible", default: false, null: false
    t.integer "subjects_id", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permalink"], name: "index_pages_on_permalink"
    t.index ["subjects_id"], name: "index_pages_on_subjects_id"
  end

  create_table "section_edits", force: :cascade do |t|
    t.bigint "admin_users_id"
    t.bigint "sections_id"
    t.string "summary", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_users_id", "sections_id"], name: "index_section_edits_on_admin_users_id_and_sections_id"
    t.index ["admin_users_id"], name: "index_section_edits_on_admin_users_id"
    t.index ["sections_id"], name: "index_section_edits_on_sections_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.integer "position", default: 0
    t.boolean "visible", default: false, null: false
    t.string "content_type", limit: 250
    t.text "content"
    t.integer "pages_id", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pages_id"], name: "index_sections_on_pages_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.integer "position", default: 0
    t.boolean "visible", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
