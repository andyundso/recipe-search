class AddThumbnailToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :thumbnail, :string, null: false, default: "https://i.insider.com/602ee9ced3ad27001837f2ac?width=700"
  end
end
