require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  describe "GET #search" do
    let(:params_with_non_numerical_page) do
      {"query"=>"omelet", "page"=>"one"}
    end    

    let(:params_with_blank_query) do
      {"query"=>"", "page"=>"1"}
    end

    context "search failed because of incorrect query parameter" do
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
