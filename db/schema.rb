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

ActiveRecord::Schema.define(:version => 20121116020858) do

  create_table "card_traits", :id => false, :force => true do |t|
    t.string  "card_code",                 :null => false
    t.string  "trait_name",                :null => false
    t.integer "level",      :default => 1, :null => false
  end

  create_table "cards", :id => false, :force => true do |t|
    t.string  "code",                           :null => false
    t.integer "cast_cost"
    t.string  "name",                           :null => false
    t.string  "description"
    t.string  "type_name",                      :null => false
    t.boolean "or_cost",     :default => false, :null => false
    t.boolean "novice",      :default => false, :null => false
    t.integer "deck_max",    :default => 4,     :null => false
  end

  create_table "deck_cards", :id => false, :force => true do |t|
    t.integer "deck_id",                  :null => false
    t.string  "card_code",                :null => false
    t.integer "amount",    :default => 1, :null => false
  end

  create_table "decks", :force => true do |t|
    t.string "title"
    t.string "description"
    t.string "mage_name",   :null => false
  end

  create_table "mage_schools", :id => false, :force => true do |t|
    t.integer "cost",        :default => 1, :null => false
    t.string  "school_name",                :null => false
    t.string  "mage_name",                  :null => false
  end

  create_table "mages", :id => false, :force => true do |t|
    t.string "name", :null => false
  end

  create_table "pack_cards", :id => false, :force => true do |t|
    t.string  "pack_name",                :null => false
    t.string  "card_code",                :null => false
    t.integer "amount",    :default => 1, :null => false
  end

  create_table "packs", :id => false, :force => true do |t|
    t.string "name", :null => false
  end

  create_table "school_levels", :id => false, :force => true do |t|
    t.integer "level",       :default => 1, :null => false
    t.string  "school_name",                :null => false
    t.string  "card_code",                  :null => false
  end

  create_table "schools", :id => false, :force => true do |t|
    t.string "name", :null => false
  end

  create_table "trait_levels", :id => false, :force => true do |t|
    t.string  "card_code",                 :null => false
    t.string  "trait_name",                :null => false
    t.integer "level",      :default => 1, :null => false
  end

  create_table "traits", :id => false, :force => true do |t|
    t.string  "name",                        :null => false
    t.boolean "additive", :default => false, :null => false
  end

  create_table "types", :id => false, :force => true do |t|
    t.string "name", :null => false
  end

end
