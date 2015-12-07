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

ActiveRecord::Schema.define(version: 20151206050238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gifs", force: true do |t|
    t.string   "url"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.decimal  "twitter_ref"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gif_id"
    t.decimal  "in_reply_to_tweet_id"
    t.string   "replying_to_user_handle"
  end

  add_index "tweets", ["gif_id"], name: "index_tweets_on_gif_id", using: :btree
  add_index "tweets", ["twitter_ref"], name: "index_tweets_on_twitter_ref", using: :btree

end
