class CreateMages < ActiveRecord::Migration
  def change
    create_table :mages do |t|
      t.string :name
    end
  end
end
