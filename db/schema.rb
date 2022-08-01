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

ActiveRecord::Schema.define(version: 2022_07_29_132447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "code_piece_users", force: :cascade do |t|
    t.bigint "code_piece_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_piece_id", "user_id"], name: "index_code_piece_users_on_code_piece_id_and_user_id", unique: true
    t.index ["code_piece_id"], name: "index_code_piece_users_on_code_piece_id"
    t.index ["user_id"], name: "index_code_piece_users_on_user_id"
  end

  create_table "code_pieces", force: :cascade do |t|
    t.bigint "project_id"
    t.string "title", default: "", null: false
    t.integer "piece_status", default: 0, null: false
    t.date "deadline"
    t.text "description"
    t.string "screenshot"
    t.string "piece_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_code_pieces_on_project_id"
    t.index ["title", "project_id"], name: "index_code_pieces_on_title_and_project_id", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.bigint "user_id"
    t.index ["name"], name: "index_projects_on_name", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.integer "user_type", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "code_piece_users", "code_pieces"
  add_foreign_key "code_piece_users", "users"
  add_foreign_key "code_pieces", "projects"
end
