class RecipeSearch
  include ActiveModel::Validations
  attr_accessor :query, :page

  validates :query, presence: true
  validates :page, numericality: { only_integer: true, greater_than: 0 }

  def initialize(params={})
    @query  = params[:query]
    @page = params[:page]
  end
end