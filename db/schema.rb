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

ActiveRecord::Schema.define(version: 20161207105344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "password",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "email"
    t.string   "phone",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_clients_on_phone", unique: true, using: :btree
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "phone",                             null: false
    t.string   "pass",                              null: false
    t.string   "auto",                              null: false
    t.string   "status",     default: "not active"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["phone"], name: "index_drivers_on_phone", unique: true, using: :btree
  end

end
