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

ActiveRecord::Schema.define(:version => 20121113141911) do

  create_table "cards", :force => true do |t|
    t.string "name"
  end

  create_table "mage_schools", :id => false, :force => true do |t|
    t.integer "mage_id",                  :null => false
    t.integer "school_id",                :null => false
    t.integer "cost",      :default => 1, :null => false
  end

  create_table "mages", :force => true do |t|
    t.string "name"
  end

  create_table "school_levels", :id => false, :force => true do |t|
    t.integer "school_id",                :null => false
    t.integer "card_id",                  :null => false
    t.integer "level",     :default => 1, :null => false
  end

  create_table "schools", :force => true do |t|
    t.string "name"
  end

  create_table "types", :force => true do |t|
    t.string "name"
  end

end
