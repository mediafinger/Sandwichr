class CreateSandwich < ActiveRecord::Migration
  def change
    create_table :sandwiches do |t|
      t.string :name
      t.string :bread_type

      t.timestamps
    end
  end
end
