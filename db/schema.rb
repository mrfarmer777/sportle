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

ActiveRecord::Schema[8.1].define(version: 2025_10_30_001937) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "found_batting_hand", default: false
    t.boolean "found_jersey_number", default: false
    t.boolean "found_league", default: false
    t.boolean "found_player", default: false
    t.boolean "found_position", default: false
    t.boolean "found_team", default: false
    t.boolean "found_throwing_hand", default: false
    t.bigint "player_target_id"
    t.string "status", default: "started"
    t.string "total_guesses", default: "0"
    t.datetime "updated_at", null: false
    t.index ["player_target_id"], name: "index_games_on_player_target_id"
  end

  create_table "player_targets", force: :cascade do |t|
    t.string "batting_hand", null: false
    t.datetime "created_at", null: false
    t.string "first_name", null: false
    t.string "jersey_number", null: false
    t.string "last_name", null: false
    t.string "league", null: false
    t.string "position", null: false
    t.string "stats_api_id", null: false
    t.string "team_name", null: false
    t.string "throwing_hand", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "stats_api_id", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "player_targets"
end
