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

ActiveRecord::Schema.define(version: 20140615173312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "payload",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "github_id",  null: false
    t.string   "commit_sha", null: false
  end

  add_index "comments", ["commit_sha"], name: "index_comments_on_commit_sha", using: :btree
  add_index "comments", ["github_id"], name: "index_comments_on_github_id", unique: true, using: :btree

  create_table "commits", force: true do |t|
    t.string   "sha",         null: false
    t.text     "payload",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "reviewed_at"
  end

  add_index "commits", ["sha"], name: "index_commits_on_sha", unique: true, using: :btree

end
