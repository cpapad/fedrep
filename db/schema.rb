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

ActiveRecord::Schema.define(version: 20171205153412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experiments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slice_urn"
    t.boolean "rated", default: false
    t.string "rstart"
    t.string "rend"
    t.string "user_urn"
    t.integer "user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "service_name"
    t.integer "testbed_id"
  end

  create_table "testbeds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "testbed_name"
    t.text "tb_alias"
    t.text "tb_urn"
    t.text "am"
    t.float "reputation", default: 0.5
    t.integer "experiments", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_urn"
    t.integer "exp_count", default: 0
    t.float "credibility", default: 0.5
  end

end
