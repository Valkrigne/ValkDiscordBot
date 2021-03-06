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

ActiveRecord::Schema.define(version: 2016_07_24_205626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "recorded_messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recorded_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "discord_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "battletag"
    t.index ["discord_id"], name: "index_users_on_discord_id"
  end

end
