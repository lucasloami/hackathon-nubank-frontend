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

ActiveRecord::Schema.define(version: 20160828094326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "message_users", force: :cascade do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id", "user_id"], name: "index_message_users_on_message_id_and_user_id", unique: true, using: :btree
    t.index ["message_id"], name: "index_message_users_on_message_id", using: :btree
    t.index ["user_id"], name: "index_message_users_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "mission_id"
    t.string   "token"
    t.string   "title"
    t.text     "content"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id"], name: "index_messages_on_mission_id", using: :btree
    t.index ["task_id"], name: "index_messages_on_task_id", using: :btree
  end

  create_table "missions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "goal"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "value"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_missions_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_users", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id", "user_id"], name: "index_skill_users_on_skill_id_and_user_id", unique: true, using: :btree
    t.index ["skill_id"], name: "index_skill_users_on_skill_id", using: :btree
    t.index ["user_id"], name: "index_skill_users_on_user_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image_url"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "category"
    t.text     "description"
    t.decimal  "value"
    t.integer  "xp"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "prize"
    t.boolean  "accepted"
    t.integer  "mission_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "title"
    t.boolean  "completed",   default: false
    t.index ["mission_id"], name: "index_tasks_on_mission_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "role_id"
    t.integer  "mentor_id"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

end
