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

ActiveRecord::Schema.define(version: 20191126234951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pets", force: :cascade do |t|
    t.string "image_url", null: false
    t.string "name", null: false
    t.integer "approximate_age", null: false
    t.string "sex", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_adoptable", default: true, null: false
    t.integer "shelter_id"
    t.string "description", null: false
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip_code", limit: 5, null: false
  end

  add_foreign_key "pets", "shelters", on_delete: :cascade
end
