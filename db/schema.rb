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

ActiveRecord::Schema.define(version: 20150224080952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annual_meetings", force: true do |t|
    t.datetime "start_at",   null: false
    t.integer  "fee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "name",              limit: 64, null: false
    t.string   "address",           limit: 64, null: false
    t.date     "birthdate"
    t.date     "left_on"
    t.string   "postal_code",       limit: 4
    t.string   "post_office",       limit: 64
    t.string   "guardian_1",        limit: 64
    t.string   "guardian_2",        limit: 64
    t.date     "joined_on",                    null: false
    t.boolean  "female",                       null: false
    t.string   "email",             limit: 64
    t.string   "guardian_1_email",  limit: 64
    t.string   "guardian_2_email",  limit: 64
    t.string   "mobile",            limit: 16
    t.string   "phone",             limit: 16
    t.string   "guardian_1_mobile", limit: 16
    t.string   "guardian_2_mobile", limit: 16
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: true do |t|
    t.integer  "member_id",  null: false
    t.integer  "amount",     null: false
    t.datetime "sent_at"
    t.datetime "paid_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["member_id"], :name => "fk__invoices_member_id"
    t.foreign_key ["member_id"], "members", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoices_member_id"
  end

  create_table "users", force: true do |t|
    t.string   "name",            limit: 64, null: false
    t.string   "email",           limit: 64, null: false
    t.string   "password_digest", limit: 64
    t.string   "password_salt",   limit: 64
    t.string   "phone",           limit: 16
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
