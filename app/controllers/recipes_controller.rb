class RecipesController < ApplicationController
  before_action :validate_params

  def search
    url = generate_url
    response = Faraday.get(url)
    recipes = JSON.parse(response.body).fetch('results', []).map { |recipe| Recipe.new(recipe) }
    render json: recipes
  end

  private

    def validate_params
      @recipeSearch = RecipeSearch.new(params)
      if !@recipeSearch.valid?
        render json: @recipeSearch.errors, status: 400
      end
    end

    def generate_url        
      "http://www.recipepuppy.com/api/?p=#{@recipeSearch.page}&q=#{@recipeSearch.query}"
    end
end
