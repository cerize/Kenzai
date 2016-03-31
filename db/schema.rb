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

ActiveRecord::Schema.define(version: 20160328183358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mudas", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "mudas", ["project_id"], name: "index_mudas_on_project_id", using: :btree
  add_index "mudas", ["user_id"], name: "index_mudas_on_user_id", using: :btree

  create_table "project_assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_manager", default: false
  end

  add_index "project_assignments", ["project_id"], name: "index_project_assignments_on_project_id", using: :btree
  add_index "project_assignments", ["user_id"], name: "index_project_assignments_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "aasm_state"
  end

  add_index "projects", ["aasm_state"], name: "index_projects_on_aasm_state", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "snippets", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "snippets", ["project_id"], name: "index_snippets_on_project_id", using: :btree
  add_index "snippets", ["user_id"], name: "index_snippets_on_user_id", using: :btree

  create_table "sprints", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sprints", ["project_id"], name: "index_sprints_on_project_id", using: :btree

  create_table "task_assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "task_assignments", ["task_id"], name: "index_task_assignments_on_task_id", using: :btree
  add_index "task_assignments", ["user_id"], name: "index_task_assignments_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "sprint_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasks", ["sprint_id"], name: "index_tasks_on_sprint_id", using: :btree

  create_table "user_stories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "sprint_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_stories", ["sprint_id"], name: "index_user_stories_on_sprint_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "mudas", "projects"
  add_foreign_key "mudas", "users"
  add_foreign_key "project_assignments", "projects"
  add_foreign_key "project_assignments", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "snippets", "projects"
  add_foreign_key "snippets", "users"
  add_foreign_key "sprints", "projects"
  add_foreign_key "task_assignments", "tasks"
  add_foreign_key "task_assignments", "users"
  add_foreign_key "tasks", "sprints"
  add_foreign_key "user_stories", "sprints"
end
