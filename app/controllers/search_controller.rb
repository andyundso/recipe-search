class SearchController < ApplicationController
  def index; end

  def find
    @recipes = Recipe.includes(:ingredients).all

    params["included"].select(&:present?).each do |included|
      @recipes = @recipes.where(ingredients: { name: included })
    end

    params["excluded"].select(&:present?).each do |excluded|
      @recipes = @recipes.where.not(ingredients: { name: excluded })
    end
  end
end
