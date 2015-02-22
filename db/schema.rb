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

ActiveRecord::Schema.define(version: 20150221233115) do

  create_table "tracks", force: :cascade do |t|
    t.integer  "soundcloud_id"
    t.integer  "soundcloud_user_id"
    t.datetime "soundcloud_created_at"
    t.string   "title"
    t.string   "uri"
    t.string   "sharing"
    t.text     "description"
    t.integer  "duration"
    t.string   "genre"
    t.boolean  "downloadable"
    t.boolean  "streamable"
    t.integer  "comment_count",         default: 0
    t.integer  "download_count",        default: 0
    t.integer  "playback_count",        default: 0
    t.integer  "favoritings_count",     default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "downloaded",            default: false
    t.boolean  "streamed",              default: false
    t.string   "download_url"
  end

  add_index "tracks", ["soundcloud_id"], name: "index_tracks_on_soundcloud_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.integer  "soundcloud_id"
    t.string   "soundcloud_username"
    t.string   "soundcloud_access_token"
    t.string   "soundcloud_refresh_token"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.datetime "favorites_updated_at",     default: '1969-01-01 00:00:00'
  end

end
