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

ActiveRecord::Schema.define(version: 20140811150828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string "name"
  end

  add_index "authors", ["name"], name: "index_authors_on_name", unique: true, using: :btree

  create_table "books", force: true do |t|
    t.string   "photo"
    t.string   "title"
    t.date     "published_on"
    t.string   "asin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "large_photo"
    t.integer  "comments_count", default: 0
  end

  create_table "comments", force: true do |t|
    t.string   "content"
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["book_id"], name: "index_comments_on_book_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contributions", force: true do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  add_index "contributions", ["author_id"], name: "index_contributions_on_author_id", using: :btree
  add_index "contributions", ["book_id"], name: "index_contributions_on_book_id", using: :btree

  create_table "follows", force: true do |t|
    t.integer "user_id"
    t.integer "followee_id"
  end

  add_index "follows", ["followee_id", "user_id"], name: "index_follows_on_followee_id_and_user_id", unique: true, using: :btree
  add_index "follows", ["user_id"], name: "index_follows_on_user_id", using: :btree

  create_table "listed_books", force: true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_index"
    t.boolean  "is_read",     default: false, null: false
  end

  add_index "listed_books", ["book_id", "user_id"], name: "index_listed_books_on_book_id_and_user_id", unique: true, using: :btree
  add_index "listed_books", ["book_id"], name: "index_listed_books_on_book_id", using: :btree
  add_index "listed_books", ["user_id"], name: "index_listed_books_on_user_id", using: :btree

  create_table "recommendations", force: true do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.integer "recipient_id"
  end

  add_index "recommendations", ["book_id"], name: "index_recommendations_on_book_id", using: :btree
  add_index "recommendations", ["recipient_id", "user_id", "book_id"], name: "index_recommendations_on_recipient_id_and_user_id_and_book_id", unique: true, using: :btree
  add_index "recommendations", ["user_id"], name: "index_recommendations_on_user_id", using: :btree

  create_table "requests", force: true do |t|
    t.integer "user_id"
    t.integer "recipient_id"
  end

  add_index "requests", ["recipient_id", "user_id"], name: "index_requests_on_recipient_id_and_user_id", unique: true, using: :btree
  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
