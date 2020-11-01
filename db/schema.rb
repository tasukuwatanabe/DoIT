# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_31_140900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labels", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.string "color"
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "shortcuts", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "label_id"
    t.index ["user_id"], name: "index_shortcuts_on_user_id"
  end

  create_table "todo_parents", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_todo_parents_on_user_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string "title", null: false
    t.date "todo_date", null: false
    t.boolean "status", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.date "start_date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.date "end_date"
    t.boolean "continue_without_end", default: false
    t.integer "apply_days", array: true
    t.boolean "history_display", default: false
    t.text "body"
    t.integer "label_id"
    t.integer "todo_parent_id"
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "user_image"
    t.string "twitter_uid"
    t.string "sns_profile_image"
    t.string "facebook_uid"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "confirmation_digest"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "google_uid"
    t.boolean "auto_generated_password", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "labels", "users"
  add_foreign_key "shortcuts", "users"
  add_foreign_key "todo_parents", "users"
  add_foreign_key "todos", "users"
end
