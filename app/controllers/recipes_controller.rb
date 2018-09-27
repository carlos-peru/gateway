class RecipesController < ApplicationController
  before_action :validate_params

  def search
    recipes, errors = SearchRecipeService.call(@recipeSearch)
    if errors.nil?
      render json: recipes
    else
      render json: errors[:message], status: errors[:status]
    end
  end

  private

    def validate_params
      @recipeSearch = RecipeSearch.new(params)
      if !@recipeSearch.valid?
        render json: @recipeSearch.errors, status: 400
      end
    end
end
