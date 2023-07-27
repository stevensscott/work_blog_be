require 'rails_helper'
# index test
RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    it "returns an array of articles" do
      get "/articles.json"
      expect(response).to have_http_status(200)
    end
  end
end

#create
describe "POST /articles" do
  it "creates an article" do
    post "/articles.json", params:{ 
      "article": {
      "title": "test title",
      "body": "This is a test article",
      "status": "public"
      }
    }
    article = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(article["title"]).to eq("test title")

   
  end
end
