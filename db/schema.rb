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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130615221523) do

  create_table "categories", :force => true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cats", :force => true do |t|
    t.integer  "cat_id"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "magnitude"
    t.integer  "karma"
    t.integer  "record_id"
  end

  create_table "cats_records", :id => false, :force => true do |t|
    t.integer  "cat_id"
    t.integer  "record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evil_wizards", :force => true do |t|
    t.integer  "cat_id"
    t.integer  "magnitude"
    t.integer  "karma"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "karmas", :force => true do |t|
    t.string   "name"
    t.decimal  "points",     :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "records", :force => true do |t|
    t.integer  "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "raw"
    t.integer  "user_id"
    t.datetime "target"
  end

  create_table "sorcerers", :force => true do |t|
    t.integer  "cat_id"
    t.integer  "magnitude"
    t.integer  "karma"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "time_zone"
    t.integer  "karma"
    t.string   "password_hash"
    t.string   "password_salt"
  end

  create_table "wizards", :force => true do |t|
    t.integer  "cat_id"
    t.integer  "magnitude"
    t.integer  "karma"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
