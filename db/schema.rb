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

ActiveRecord::Schema.define(version: 20161226134609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.string   "email",                                  null: false
    t.string   "encrypted_password",                     null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "blocked",                default: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "email"
    t.string   "phone",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_clients_on_phone", unique: true, using: :btree
  end

  create_table "dispatchers", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "blocked",                default: false
    t.index ["email"], name: "index_dispatchers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_dispatchers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name",                                          null: false
    t.string   "phone",                                         null: false
    t.string   "encrypted_password",                            null: false
    t.string   "auto",                                          null: false
    t.string   "status",                 default: "not active"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "blocked",                default: false
    t.index ["phone"], name: "index_drivers_on_phone", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_drivers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "driver_id"
    t.string   "from",                                                   null: false
    t.string   "to",                                                     null: false
    t.string   "state",                              default: "waiting", null: false
    t.decimal  "price",      precision: 5, scale: 2
    t.text     "comment"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.boolean  "req",                                default: false
    t.index ["client_id"], name: "index_orders_on_client_id", using: :btree
    t.index ["driver_id"], name: "index_orders_on_driver_id", using: :btree
  end

  create_table "requests", force: :cascade do |t|
    t.text     "comment",                   null: false
    t.integer  "driver_id"
    t.boolean  "request",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["driver_id"], name: "index_requests_on_driver_id", using: :btree
  end

  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "drivers"
  add_foreign_key "requests", "drivers"
end
