class SearchRecipeService
    attr_reader :query, :page

    def initialize(recipe_search)
      @query = recipe_search.query
      @page = recipe_search.page      
    end

    def self.call(recipe_search)      
      new(recipe_search).call
    end
    
    def call        
      response = request
      if (response.status == 200)
        recipes = JSON.parse(response.body).fetch('results', []).map { |recipe| Recipe.new(recipe) }
      else
        errors(response)
      end         
      [ recipes, response[:errors] ]
    end

    private 

      def request        
        url = generate_url
        Faraday.get(url)
      end

      def errors(response)        
        error = { errors: { status: response[:status], message: response[:message] } }
        response.merge(error)
      end
      
      def generate_url        
        "http://www.recipepuppy.com/api/?p=#{@page}&q=#{@query}"
      end
    
end