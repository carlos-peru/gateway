require 'rails_helper'

describe RecipesController do

  describe "GET #search" do
    context "search succeeded" do
      let(:params) do
        {"query"=>"omelet", "page"=>"1"}
      end
      
      let(:recipes) do
        create_list(:recipe, 10) 
      end
      
      before do
        allow(SearchRecipeService).to receive(:new) {
          -> { recipes }
        }
      end

      it "returns a correct status code" do
        get :search, params: params
        expect(response.status).to eq 200
      end

      it "returns the recipes in json" do
        get :search, params: params
        expect(JSON.parse(response.body)).to eq recipes.as_json
      end
    end

    context "search failed because of incorrect query parameter" do 
      let(:params_with_blank_query) do
        { "query" => "", "page" => "1" }
      end

      it "returns a correct status code" do
        get :search, params: params_with_blank_query
        expect(response.status).to eq 400
      end

      it "returns correct message" do
        get :search, params: params_with_blank_query
        error = JSON.parse(response.body)
        expect(error["query"]).to eq ["can't be blank"]
      end
    end

    context "search failed because of incorrect page parameter" do
      let(:params_with_non_numerical_page) do
        { "query" => "omelet", "page" => "one" }
      end

      it "returns a correct status code" do
        get :search, params: params_with_non_numerical_page
        expect(response.status).to eq 400
      end

      it "returns correct message" do
        get :search, params: params_with_non_numerical_page
        error = JSON.parse(response.body)
        expect(error["page"]).to eq ["is not a number"]
      end
    end
  end

end
