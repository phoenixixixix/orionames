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

ActiveRecord::Schema[7.0].define(version: 2022_11_13_193347) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "names", force: :cascade do |t|
    t.string "title"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "origin_country_id"
    t.datetime "fete_days", default: [], array: true
    t.string "capital_letter"
    t.index ["origin_country_id"], name: "index_names_on_origin_country_id"
  end

  create_table "origin_countries", force: :cascade do |t|
    t.string "title"
    t.string "uk_title"
    t.string "uk_title_plural"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "popular_female_names", force: :cascade do |t|
    t.integer "name_id"
    t.string "name_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "popular_male_names", force: :cascade do |t|
    t.integer "name_id"
    t.string "name_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wikis", force: :cascade do |t|
    t.text "origin"
    t.text "meaning"
    t.bigint "name_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_id"], name: "index_wikis_on_name_id"
  end

  add_foreign_key "names", "origin_countries"
end
