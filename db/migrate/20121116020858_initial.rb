class Initial < ActiveRecord::Migration
  def e(what)
    connection.execute what
  end

  def fk(table, col, join, join_col)
    e <<-SQL
      alter table #{table} add constraint fk_#{col} foreign key (#{col}) references #{join}(#{join_col})
    SQL
  end

  def pk(table, *cols)
    e <<-SQL
      alter table #{table} add primary key (#{cols.join(',')})
    SQL
  end

  def up
    create_table "types", :id =>false, :force => true do |t|
      t.string "name", :null => false
    end

    pk('types', 'name')

    create_table "traits", :id => false, :force => true do |t|
      t.string  "name",     :null => false
      t.boolean "additive", :null => false, :default => false
    end

    pk('traits', 'name')

    create_table "cards", :id => false, :force => true do |t|
      t.string "code",                     :null => false
      t.integer 'cast_cost', :null => false
      t.string "name",                     :null => false
      t.string "description"
      t.string "type_name",  :null => false
      t.boolean "or_cost",  :null => false, :default => false
      t.boolean 'novice', :null => false, :default => false
    end
    pk('cards', 'code')
    fk('cards', 'type_name', 'types', 'name')

    create_table "mages", :id => false, :force => true do |t|
      t.string "name", :null => false
    end
    pk('mages', 'name')
    
    create_table "schools", :id => false, :force => true do |t|
      t.string "name", :null => false
    end
    pk('schools', 'name')

    create_table "card_traits", :id => false, :force => true do |t|
      t.string "card_code", :null => false
      t.string "trait_name",:null => false
      t.integer "level", :default => 1, :null => false
    end
    pk('card_traits', 'card_code', 'trait_name')
    fk('card_traits', 'card_code', 'cards', 'code')
    fk('card_traits', 'trait_name', 'traits', 'name')

    create_table "mage_schools", :id => false, :force => true do |t|
      t.integer "cost",              :default => 1, :null => false
      t.string  "school_name",  :null => false
      t.string  "mage_name", :null => false
    end
    pk('mage_schools', 'school_name', 'mage_name')
    fk('mage_schools', 'school_name', 'schools', 'name')
    fk('mage_schools', 'mage_name', 'mages', 'name')

    create_table "school_levels", :id => false, :force => true do |t|
      t.integer "level",               :default => 1, :null => false
      t.string  "school_name",  :null => false
      t.string  "card_code",    :null => false
    end
    pk('school_levels', 'card_code', 'school_name')
    fk('school_levels', 'school_name', 'schools', 'name')
    fk('school_levels', 'card_code', 'cards', 'code')

    create_table "trait_levels", :id => false, :force => true do |t|
      t.string 'card_code', :null => false
      t.string 'trait_name', :null => false
      t.integer 'level', :null => false, :default => 1
    end
    pk('trait_levels', 'card_code', 'trait_name')
    fk('trait_levels', 'card_code' , 'cards', 'code')
    fk('trait_levels', 'trait_name' , 'traits', 'name')
  end

  def down
    drop_table "trait_levels"
    drop_table "school_levels"
    drop_table "mage_schools"
    drop_table "card_traits"
    drop_table "schools"
    drop_table "mages"
    drop_table "cards"
    drop_table "traits"
    drop_table "types"
  end
end
