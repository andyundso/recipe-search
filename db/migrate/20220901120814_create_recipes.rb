class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes, id: :uuid do |t|
      t.string :name, null: false
      t.string :url, null: true

      t.timestamps
    end

    create_join_table :recipes, :ingredients, column_options: {type: :uuid} do |t|
      t.index [:recipe_id, :ingredient_id]
    end
  end
end
