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

ActiveRecord::Schema.define(:version => 20130417155546) do

  create_table "notes", :force => true do |t|
    t.datetime "datetime"
    t.string   "summary"
    t.string   "type"
    t.integer  "request_id"
  end

  create_table "requests", :id => false, :force => true do |t|
    t.string "service_request_id"
    t.string "status"
    t.string "service_name"
    t.string "service_code"
    t.string "description"
    t.string "requested_datetime"
    t.string "updated_datetime"
  end

end
