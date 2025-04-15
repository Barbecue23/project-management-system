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

ActiveRecord::Schema[7.1].define(version: 2025_04_15_142833) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "records", force: :cascade do |t|
    t.string "title"
    t.string "student_name"
    t.string "year"
    t.string "category"
    t.string "record_type"
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
    t.string "year_term", null: false
    t.bigint "advisor_group_member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "accepted", null: false
    t.index ["advisor_group_member_id"], name: "index_student_group_members_on_advisor_group_member_id"
    t.index ["season_id"], name: "index_student_group_members_on_season_id"
    t.index ["status"], name: "index_student_group_members_on_status"
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
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
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
