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

ActiveRecord::Schema[7.2].define(version: 2024_09_22_041445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "player_1_id", null: false
    t.bigint "player_2_id", null: false
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_at"], name: "index_friendships_on_accepted_at"
    t.index ["player_1_id", "player_2_id"], name: "index_friendships_on_player_1_id_and_player_2_id", unique: true
    t.index ["player_1_id"], name: "index_friendships_on_player_1_id"
    t.index ["player_2_id"], name: "index_friendships_on_player_2_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "invitee_id", null: false
    t.bigint "inviter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitee_id"], name: "index_invites_on_invitee_id"
    t.index ["inviter_id"], name: "index_invites_on_inviter_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "latitude", default: "", null: false
    t.string "longitude", default: "", null: false
    t.string "address", default: "", null: false
  end

  create_table "match_confirmations", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "confirmed_by_id", null: false
    t.datetime "confirmed_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmed_by_id"], name: "index_match_confirmations_on_confirmed_by_id"
    t.index ["match_id"], name: "index_match_confirmations_on_match_id"
  end

  create_table "match_players", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_players_on_match_id"
    t.index ["player_id"], name: "index_match_players_on_player_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.datetime "played_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "winner_team_id"
    t.boolean "draft", default: false
    t.index ["location_id"], name: "index_matches_on_location_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "confirmed_at", precision: nil
    t.string "confirmation_token"
    t.index ["confirmation_token"], name: "index_players_on_confirmation_token", unique: true
  end

  create_table "score_sets", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score"
    t.integer "team_id"
    t.integer "position"
    t.index ["match_id"], name: "index_score_sets_on_match_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.datetime "played_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_sessions_on_location_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "friendships", "players", column: "player_1_id"
  add_foreign_key "friendships", "players", column: "player_2_id"
  add_foreign_key "invites", "players", column: "invitee_id"
  add_foreign_key "invites", "players", column: "inviter_id"
  add_foreign_key "match_confirmations", "matches"
  add_foreign_key "match_confirmations", "players", column: "confirmed_by_id"
  add_foreign_key "match_players", "matches"
  add_foreign_key "match_players", "players"
  add_foreign_key "matches", "locations"
  add_foreign_key "score_sets", "matches"
  add_foreign_key "sessions", "locations"
end
