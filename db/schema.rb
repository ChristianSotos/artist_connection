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

ActiveRecord::Schema.define(version: 20160817231752) do

  create_table "admins", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "references", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "phone_number"
    t.string   "field"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "song_references", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "reference_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "song_references", ["reference_id"], name: "index_song_references_on_reference_id"
  add_index "song_references", ["song_id"], name: "index_song_references_on_song_id"

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.integer  "play_count"
    t.string   "key"
    t.integer  "bpm"
    t.text     "analysis"
    t.integer  "rating"
    t.boolean  "reviewed"
    t.integer  "genre_id"
    t.integer  "user_id"
    t.integer  "admin_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "audio_file_file_name"
    t.string   "audio_file_content_type"
    t.integer  "audio_file_file_size"
    t.datetime "audio_file_updated_at"
    t.boolean  "public"
  end

  add_index "songs", ["admin_id"], name: "index_songs_on_admin_id"
  add_index "songs", ["genre_id"], name: "index_songs_on_genre_id"
  add_index "songs", ["user_id"], name: "index_songs_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "artist_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "password_digest"
    t.text     "description"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "soundcloud"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

end
