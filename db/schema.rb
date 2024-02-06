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

ActiveRecord::Schema[7.1].define(version: 2024_02_06_055655) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "client_name"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "department_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "designations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_hierarchies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "to_user_id"
    t.bigint "cc_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cc_user_id"], name: "index_email_hierarchies_on_cc_user_id"
    t.index ["to_user_id"], name: "index_email_hierarchies_on_to_user_id"
    t.index ["user_id"], name: "index_email_hierarchies_on_user_id"
  end

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
    t.bigint "user_id", null: false
    t.bigint "client_id", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.bigint "company_id"
    t.bigint "department_id"
    t.bigint "designation_id"
    t.string "f_name"
    t.string "l_name"
    t.date "dateofBirth"
    t.integer "accountnumber"
    t.string "ifsc"
    t.string "mobileNumber"
    t.date "joiningDate"
    t.boolean "isactive", default: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["designation_id"], name: "index_users_on_designation_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "workreports", force: :cascade do |t|
    t.date "date"
    t.text "tasks"
    t.integer "hours"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.integer "minutes"
    t.index ["project_id"], name: "index_workreports_on_project_id"
    t.index ["user_id"], name: "index_workreports_on_user_id"
  end

  add_foreign_key "email_hierarchies", "users"
  add_foreign_key "email_hierarchies", "users", column: "cc_user_id"
  add_foreign_key "email_hierarchies", "users", column: "to_user_id"
  add_foreign_key "projects", "clients"
  add_foreign_key "projects", "users"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "designations"
  add_foreign_key "users", "roles"
  add_foreign_key "workreports", "projects"
  add_foreign_key "workreports", "users"
end
