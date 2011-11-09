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

ActiveRecord::Schema.define(:version => 20111108190002) do

  create_table "categories", :force => true do |t|
    t.text      "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "cats", :force => true do |t|
    t.integer   "cat_id"
    t.text      "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "magnitude"
    t.integer   "karma"
    t.integer   "record_id"
  end

  create_table "cats_records", :id => false, :force => true do |t|
    t.integer   "cat_id"
    t.integer   "record_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "evil_wizards", :force => true do |t|
    t.integer   "cat_id"
    t.integer   "magnitude"
    t.integer   "karma"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "karmas", :force => true do |t|
    t.string    "name"
    t.integer   "points"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "measures", :force => true do |t|
    t.text      "name"
    t.integer   "value"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "records", :force => true do |t|
    t.integer   "record_id"
    t.integer   "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "raw"
  end

  create_table "sorcerers", :force => true do |t|
    t.integer   "cat_id"
    t.integer   "magnitude"
    t.integer   "karma"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "wizards", :force => true do |t|
    t.integer   "cat_id"
    t.integer   "magnitude"
    t.integer   "karma"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
