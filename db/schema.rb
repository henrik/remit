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

ActiveRecord::Schema.define(version: 20160203135406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "username",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "payload",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "github_id",                         null: false
    t.string   "commit_sha",            limit: 255, null: false
    t.integer  "author_id",                         null: false
    t.datetime "resolved_at"
    t.integer  "resolved_by_author_id"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["commit_sha"], name: "index_comments_on_commit_sha", using: :btree
  add_index "comments", ["github_id"], name: "index_comments_on_github_id", unique: true, using: :btree
  add_index "comments", ["resolved_by_author_id"], name: "index_comments_on_resolved_by_author_id", using: :btree

  create_table "commits", force: :cascade do |t|
    t.string   "sha",                         limit: 255, null: false
    t.text     "payload",                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "reviewed_at"
    t.integer  "author_id",                               null: false
    t.integer  "reviewed_by_author_id"
    t.datetime "review_started_at"
    t.integer  "review_started_by_author_id"
    t.text     "json_payload"
  end

  add_index "commits", ["author_id"], name: "index_commits_on_author_id", using: :btree
  add_index "commits", ["review_started_by_author_id"], name: "index_commits_on_review_started_by_author_id", using: :btree
  add_index "commits", ["reviewed_by_author_id"], name: "index_commits_on_reviewed_by_author_id", using: :btree
  add_index "commits", ["sha"], name: "index_commits_on_sha", unique: true, using: :btree

end
