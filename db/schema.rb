# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140615015916) do

  create_table "groups", force: true do |t|
    t.string   "group_letter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.string   "api_id"
    t.datetime "start_time"
    t.string   "home_team_id"
    t.string   "away_team_id"
    t.integer  "home_score"
    t.integer  "away_score"
    t.string   "status"
    t.integer  "current_game_minutes"
    t.string   "venue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_matches", force: true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.boolean  "home_team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "api_id"
    t.string   "name"
    t.string   "logo"
    t.string   "website"
    t.string   "group_letter"
    t.integer  "group_rank"
    t.integer  "group_points"
    t.integer  "matches_played"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "draws"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.string   "goal_differential"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
