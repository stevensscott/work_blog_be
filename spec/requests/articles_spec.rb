require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    it "returns an array of articles" do
      get "/articles.json"
      expect(response).to have_http_status(200)
    end
  end
end


# require "rails_helper"

# RSpec.describe "Recipes", type: :request do
#   describe "GET /recipes" do
#     it "returns an array of recipes" do
#       get "/recipes.json"
#       recipes = JSON.parse(response.body)

#       expect(response).to have_http_status(200)
#       expect(recipes.length).to eq(7)
#     end
#   end
# end
