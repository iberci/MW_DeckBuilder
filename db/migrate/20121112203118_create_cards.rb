class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
    end
  end
end
