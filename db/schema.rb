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

ActiveRecord::Schema.define(:version => 20130404162238) do

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
    t.string  "invitation_label"
  end

  add_index "guests", ["family_id"], :name => "index_guests_on_family_id"
  add_index "guests", ["name"], :name => "index_guests_on_name"

  create_table "invitations", :force => true do |t|
    t.string   "label"
    t.integer  "family_id"
    t.integer  "wedding_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.integer  "kids"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invitations", ["wedding_id", "family_id"], :name => "index_invitations_on_wedding_id_and_family_id"
  add_index "invitations", ["wedding_id"], :name => "index_invitations_on_wedding_id"

  create_table "participants", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.integer  "wedding_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "participants", ["wedding_id", "type"], :name => "index_participants_on_wedding_id_and_type"

  create_table "users", :force => true do |t|
    t.string    "email",                  :default => "", :null => false
    t.string    "encrypted_password",     :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weddings", :force => true do |t|
    t.integer  "bride_id"
    t.integer  "groom_id"
    t.date     "wedding_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
