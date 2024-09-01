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

ActiveRecord::Schema[7.2].define(version: 2024_09_01_185326) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.datetime "played_at", null: false
    t.bigint "team_1_id", null: false
    t.bigint "team_2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "location_id" ], name: "index_matches_on_location_id"
    t.index [ "team_1_id" ], name: "index_matches_on_team_1_id"
    t.index [ "team_2_id" ], name: "index_matches_on_team_2_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "score_sets", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.integer "score_1", null: false
    t.integer "score_2", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "match_id" ], name: "index_score_sets_on_match_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.datetime "played_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "location_id" ], name: "index_sessions_on_location_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "player_1_id", null: false
    t.bigint "player_2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "player_1_id" ], name: "index_teams_on_player_1_id"
    t.index [ "player_2_id" ], name: "index_teams_on_player_2_id"
  end

  add_foreign_key "matches", "locations"
  add_foreign_key "matches", "teams", column: "team_1_id"
  add_foreign_key "matches", "teams", column: "team_2_id"
  add_foreign_key "score_sets", "matches"
  add_foreign_key "sessions", "locations"
  add_foreign_key "teams", "players", column: "player_1_id"
  add_foreign_key "teams", "players", column: "player_2_id"
end
