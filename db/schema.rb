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

ActiveRecord::Schema.define(:version => 20130312132451) do

  create_table "families", :force => true do |t|
    t.string "name"
  end

  create_table "guests", :force => true do |t|
    t.string  "street"
    t.string  "city"
    t.string  "state",             :default => "OH"
    t.string  "zip"
    t.integer "additional_guests", :default => 0
    t.integer "kids",              :default => 0
    t.integer "family_id"
    t.string  "name"
    t.integer "size",              :default => 1
    t.text    "notes"
  end

  add_index "guests", ["family_id"], :name => "index_guests_on_family_id"
  add_index "guests", ["name"], :name => "index_guests_on_name"

end
