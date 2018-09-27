class RecipesController < ApplicationController
  before_action :validate_params

  def search
    recipes = SearchRecipeService.call(@recipeSearch)
    render json: recipes
  end

  private

    def validate_params
      @recipeSearch = RecipeSearch.new(params)
      if !@recipeSearch.valid?
        render json: @recipeSearch.errors, status: 400
      end
    end
end
