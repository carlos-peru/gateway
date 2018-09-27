class Recipe
  attr_accessor :title, :href, :ingredients, :thumbnail
  
  def initialize(title, href, ingredients, thumbnail)
    @title = title
    @href = href
    @ingredients = ingredients
    @thumbnail = thumbnail
  end
end