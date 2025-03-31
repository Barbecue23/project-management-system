# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_26_084815) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advisor_group_members", force: :cascade do |t|
    t.bigint "advisor_group_id", null: false
    t.bigint "user_id", null: false
    t.boolean "is_owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_group_id"], name: "index_advisor_group_members_on_advisor_group_id"
    t.index ["user_id"], name: "index_advisor_group_members_on_user_id"
  end

  create_table "advisor_groups", force: :cascade do |t|
    t.string "group_name"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "advisor_requests", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "advisor_group_member_id", null: false
    t.string "status", null: false
    t.string "season_year_term", null: false
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_group_member_id"], name: "index_advisor_requests_on_advisor_group_member_id"
    t.index ["student_id"], name: "index_advisor_requests_on_student_id"
  end

  create_table "map_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.boolean "can_view", default: false
    t.boolean "can_create", default: false
    t.boolean "can_edit", default: false
    t.boolean "can_delete", default: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_map_permissions_on_permission_id"
    t.index ["role_id"], name: "index_map_permissions_on_role_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.boolean "is_public"
    t.string "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "publish_date"
  end

  create_table "news_groups", force: :cascade do |t|
    t.bigint "news_id", null: false
    t.bigint "advisor_group_id", null: false
    t.string "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_group_id"], name: "index_news_groups_on_advisor_group_id"
    t.index ["news_id"], name: "index_news_groups_on_news_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "default_view", default: false
    t.boolean "default_create", default: false
    t.boolean "default_edit", default: false
    t.boolean "default_delete", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.jsonb "seasons_detail", default: {}, null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "season_name"
  end

  create_table "student_group_members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "season_id", null: false
    t.integer "year_term", null: false
    t.bigint "advisor_group_member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_group_member_id"], name: "index_student_group_members_on_advisor_group_member_id"
    t.index ["season_id"], name: "index_student_group_members_on_season_id"
    t.index ["user_id"], name: "index_student_group_members_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "student_id"
    t.string "email"
    t.string "faculty"
    t.string "major"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.string "expertise"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "advisor_group_members", "advisor_groups"
  add_foreign_key "advisor_group_members", "users"
  add_foreign_key "advisor_requests", "advisor_group_members"
  add_foreign_key "advisor_requests", "users", column: "student_id"
  add_foreign_key "map_permissions", "permissions"
  add_foreign_key "map_permissions", "roles"
  add_foreign_key "news_groups", "advisor_groups"
  add_foreign_key "news_groups", "news"
  add_foreign_key "student_group_members", "advisor_group_members"
  add_foreign_key "student_group_members", "seasons"
  add_foreign_key "student_group_members", "users"
  add_foreign_key "users", "roles"
end
