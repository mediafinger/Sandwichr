class AddAmountToSandwichIngredient < ActiveRecord::Migration
  def change
    add_column :sandwich_ingredients, :amount, :float
  end
end
