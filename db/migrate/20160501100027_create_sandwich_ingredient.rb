class CreateSandwichIngredient < ActiveRecord::Migration
  def change
    create_table :sandwich_ingredients do |t|
      t.belongs_to :sandwich, index: true
      t.belongs_to :ingredient, index: true

      t.timestamps
    end
  end
end
