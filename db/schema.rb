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

ActiveRecord::Schema.define(version: 2020_03_24_171308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bits", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "current_points", force: :cascade do |t|
    t.integer "value"
  end

  create_table "donations", force: :cascade do |t|
    t.string "name"
    t.string "currency"
    t.integer "amount"
    t.string "from_name"
    t.string "from_id"
  end

  create_table "high_scores", force: :cascade do |t|
    t.integer "value"
  end

  create_table "incentives", force: :cascade do |t|
    t.integer "value"
  end

  create_table "point_per_bits", force: :cascade do |t|
    t.integer "value"
  end

  create_table "point_per_donations", force: :cascade do |t|
    t.integer "value"
  end

  create_table "point_per_subscriptions", force: :cascade do |t|
    t.integer "value"
    t.string "sub_type"
  end

  create_table "sound_attachments", force: :cascade do |t|
    t.string "attachment"
  end

  create_table "streamlab_logs", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.integer "sub_plan"
    t.string "sub_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
