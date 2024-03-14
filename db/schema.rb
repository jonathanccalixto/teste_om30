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

ActiveRecord::Schema[7.1].define(version: 2024_03_13_022652) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "municipes", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "cpf", default: "", null: false
    t.string "cns", default: "", null: false
    t.string "email", default: "", null: false
    t.date "birthday", null: false
    t.string "tellphone", default: "", null: false
    t.string "status", default: "active", null: false
    t.datetime "inactivated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cns"], name: "index_municipes_on_cns", unique: true
    t.index ["cpf"], name: "index_municipes_on_cpf", unique: true
    t.index ["email"], name: "index_municipes_on_email"
    t.index ["name"], name: "index_municipes_on_name"
    t.index ["status"], name: "index_municipes_on_status"
    t.index ["tellphone"], name: "index_municipes_on_tellphone"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
