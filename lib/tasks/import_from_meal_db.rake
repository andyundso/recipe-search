require 'net/http'

namespace :meal_db do
  task import: :environment do
    ActiveRecord::Base.transaction do
      Recipe.destroy_all
      Ingredient.destroy_all

      ('a'..'z').each do |letter|
        meal_db_source = "https://www.themealdb.com/api/json/v1/1/search.php?f=#{letter}"
        meal_db_recipes = JSON.parse(Net::HTTP.get_response(URI.parse(meal_db_source)).body)

        meal_db_recipes['meals']&.each do |meal_db_recipe|
          puts "importing recipe #{meal_db_recipe['strMeal']} ..."

          recipe = Recipe.find_or_initialize_by(
            name: meal_db_recipe['strMeal'].downcase
          )
          recipe.url = meal_db_recipe['strSource']
          recipe.thumbnail = meal_db_recipe['strMealThumb']
          recipe.save!

          (1..20).each do |number|
            next if meal_db_recipe["strIngredient#{number}"].blank?

            ingredient = Ingredient.find_or_initialize_by(
              name: meal_db_recipe["strIngredient#{number}"].downcase
            )

            ingredient.recipes << recipe
            ingredient.save!
          end
        end
      end
    end
  end
end
