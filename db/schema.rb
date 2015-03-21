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

ActiveRecord::Schema.define(version: 20150321195247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campuses", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "instructor_id", null: false
    t.integer "topic_id",      null: false
    t.integer "campus_id",     null: false
    t.date    "start_on",      null: false
    t.text    "data"
    t.integer "timeline_id"
  end

  add_index "courses", ["campus_id"], name: "index_courses_on_campus_id", using: :btree
  add_index "courses", ["instructor_id"], name: "index_courses_on_instructor_id", using: :btree
  add_index "courses", ["timeline_id"], name: "index_courses_on_timeline_id", using: :btree
  add_index "courses", ["topic_id"], name: "index_courses_on_topic_id", using: :btree

  create_table "instructors", force: :cascade do |t|
    t.integer "user_id"
    t.string  "first_name",       null: false
    t.string  "last_name",        null: false
    t.string  "email",            null: false
    t.integer "active_course_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "github_username"
    t.string   "github_id",       null: false
  end

  add_index "students", ["course_id"], name: "index_students_on_course_id", using: :btree

  create_table "timelines", force: :cascade do |t|
    t.integer "topic_id"
    t.string  "title"
    t.text    "description"
    t.text    "goals"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "google_auth_id"
    t.text     "google_auth_data"
    t.string   "name",                                   null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "github_auth_id"
    t.text     "github_auth_data"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "courses", "campuses"
  add_foreign_key "courses", "instructors"
  add_foreign_key "courses", "timelines"
  add_foreign_key "courses", "topics"
  add_foreign_key "students", "courses"
end
