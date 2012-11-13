class CreateMageSchools < ActiveRecord::Migration
  def up
    create_table :mage_schools, id:false do |t|
      t.integer :mage_id, null:false
      t.integer :school_id, null:false
      t.integer :cost, null:false, default:1
    end

    connection.execute("alter table mage_schools add constraint fk_mage_id foreign key (mage_id) references mages(id)")
    connection.execute("alter table mage_schools add constraint fk_school_id foreign key (school_id) references schools(id)")
    connection.execute("alter table mage_schools add primary key (mage_id, school_id)")
  end

  def down
    drop_table :mage_schools
  end
end
