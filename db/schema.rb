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

ActiveRecord::Schema.define(:version => 20120119144217) do

  create_table "hourly_statistics", :force => true do |t|
    t.integer  "statistic_id"
    t.integer  "change_in_uploaded"
    t.integer  "change_in_downloaded"
    t.integer  "change_in_uploads"
    t.integer  "change_in_snatched"
    t.integer  "change_in_posts"
    t.integer  "change_in_seeding"
    t.integer  "change_in_leeching"
    t.integer  "change_in_buffer"
    t.decimal  "change_in_ratio"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "statistics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "uploaded"
    t.integer  "downloaded"
    t.integer  "seeding"
    t.integer  "leeching"
    t.integer  "posts"
    t.integer  "uploads"
    t.integer  "snatched"
    t.decimal  "ratio"
    t.integer  "buffer"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "what_uid"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
