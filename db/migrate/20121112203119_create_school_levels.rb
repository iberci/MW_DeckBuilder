class CreateSchoolLevels < ActiveRecord::Migration
  def up
    create_table :school_levels, id:false do |t|
      t.integer :school_id, null:false
      t.integer :card_id, null:false
      t.integer :level, null:false, default:1

    end

    connection.execute 'alter table school_levels add primary key (card_id, school_id)'
    connection.execute 'alter table school_levels add constraint fk_school_id foreign key (school_id) references schools(id)'
    connection.execute 'alter table school_levels add constraint fk_card_id foreign key (card_id) references cards(id)'
  end

  def down
    drop_table :school_levels
  end
end
