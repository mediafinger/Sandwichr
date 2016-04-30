class CreateIngredient < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :calories

      t.timestamps
    end
  end
end
