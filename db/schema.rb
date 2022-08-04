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

ActiveRecord::Schema.define(version: 2022_08_04_064907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bug_users", force: :cascade do |t|
    t.bigint "bug_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bug_id", "user_id"], name: "index_bug_users_on_bug_id_and_user_id", unique: true
    t.index ["bug_id"], name: "index_bug_users_on_bug_id"
    t.index ["user_id"], name: "index_bug_users_on_user_id"
  end

  create_table "bugs", force: :cascade do |t|
    t.bigint "project_id"
    t.string "title", default: "", null: false
    t.integer "piece_status", default: 0, null: false
    t.date "deadline"
    t.text "description"
    t.string "screenshot"
    t.string "piece_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "qa_id"
    t.bigint "developer_id"
    t.index ["developer_id"], name: "index_bugs_on_developer_id"
    t.index ["project_id"], name: "index_bugs_on_project_id"
    t.index ["qa_id"], name: "index_bugs_on_qa_id"
    t.index ["title", "project_id"], name: "index_bugs_on_title_and_project_id", unique: true
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
    t.integer "manager_id"
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

  add_foreign_key "bug_users", "bugs"
  add_foreign_key "bug_users", "users"
  add_foreign_key "bugs", "projects"
  add_foreign_key "bugs", "users", column: "developer_id"
  add_foreign_key "bugs", "users", column: "qa_id"
end
