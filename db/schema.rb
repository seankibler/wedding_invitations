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

ActiveRecord::Schema.define(:version => 20130525220052) do

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "user_agent"
    t.string   "referrer"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string "name"
  end

  create_table "guests", :force => true do |t|
    t.string  "name"
    t.integer "invitation_id"
  end

  add_index "guests", ["invitation_id"], :name => "index_guests_on_invitation_id"
  add_index "guests", ["name"], :name => "index_guests_on_name"

  create_table "invitations", :force => true do |t|
    t.string   "outer_label"
    t.integer  "group_id"
    t.integer  "wedding_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.integer  "kids"
    t.integer  "size"
    t.text     "notes"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "sent_at"
    t.boolean  "rsvp_response"
  end

  add_index "invitations", ["sent_at"], :name => "index_invitations_on_sent_at"
  add_index "invitations", ["wedding_id", "rsvp_response"], :name => "index_invitations_on_wedding_id_and_rsvp_response"
  add_index "invitations", ["wedding_id"], :name => "index_invitations_on_wedding_id"

  create_table "payments", :force => true do |t|
    t.integer "wedding_id"
    t.string  "stripe_customer_id"
    t.string  "stripe_charge_id"
  end

  add_index "payments", ["wedding_id"], :name => "index_payments_on_wedding_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_weddings", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "wedding_id"
  end

  create_table "weddings", :force => true do |t|
    t.integer  "bride_id"
    t.integer  "groom_id"
    t.date     "wedding_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
