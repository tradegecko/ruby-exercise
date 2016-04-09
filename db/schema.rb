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

ActiveRecord::Schema.define(version: 20160409170615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mentions", force: true do |t|
    t.string   "content"
    t.string   "mention_tweet_id"
    t.string   "reply_content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state"
    t.string   "screen_name"
  end

  create_table "tweets", force: true do |t|
    t.string   "content",                    null: false
    t.datetime "tweeted_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state"
    t.boolean  "reply",      default: false
    t.integer  "mention_id"
  end

end
