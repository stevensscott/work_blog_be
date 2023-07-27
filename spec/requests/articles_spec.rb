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
    expect(article["body"]).to eq("This is a test article")
    expect(article["status"]).to eq("public")

  end
end

#show
describe "GET /articles/:id" do
  it "gets a specific article" do    
    my_article=Article.create!(title: "example title 1", body: "this is my article body 12345", status: "public")   
    article_id = Article.first.id
    get "/articles/#{article_id}.json"
    article = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(article["id"]).to eq(article_id)
    expect(article["title"]).to eq("example title 1")
    expect(article["body"]).to eq("this is my article body 12345")
    expect(article["status"]).to eq("public")    
  end
end

#update
describe "PATCH /articles/:id" do
  it "updates an existing article" do    
    my_article=Article.create!(title: "example title 1", body: "this is my article body 12345", status: "public")   
    article_id = Article.first.id  
    patch "/articles/#{article_id}.json", params:{ 
      "article": {
      "title": "updated_article",
      "body": "This is a test article",
      "status": "public"
      }
    }
    article = JSON.parse(response.body)
    p article["title"]

    expect(response).to have_http_status(200)
    expect(article["id"]).to eq(article_id)
    expect(article["title"]).to eq("updated_article")
    expect(article["body"]).to eq("This is a test article")
    expect(article["status"]).to eq("public")    
  end
end
