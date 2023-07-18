class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: "test", password: "test", except: [:index, :show]
  
  def index
    @articles = Article.all

    #  respond_to code block will allow you to render the html if you're in your browser visiting localhost:3000, OR render json if you're making a web request with '.json' at the end 
    respond_to do |format|
      format.html { @articles }
      # format.json { render json: @articles.as_json }
      format.json { render json: @articles.as_json(include:[:comments]) }
    end
  end
  # This won't work until I create a seperate show render page I think since I only have the content page it shows the index as well as the show
  def show
     @article = Article.find(params[:id])
    # respond_to do |format|
    #   format.html { @article }
    #   format.json { render json: @article.as_json }
    # end
  end

  def new
    @article = Article.new
  end

  def create  
    # I'm now using a new private function instead of explicitly writing out each article attribute per the rails tutorial.
    @article = Article.new(article_params)
   
   

    if @article.save     
      # the respond_to allows you to have a Rails frontend (html) and a React frontend (json)
      respond_to do |format|
        format.html do
          p "In format html"
          redirect_to @article
        end
        
        format.json do  
          p "In format json"       
          render json: @article.as_json
        end
      end
    else        
      render :json => { :errors => @article.errors.full_messages }
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    p "article #{@article.to_json}"

    if @article.update(article_params)
      p "article params #{article_params.to_json}"
      render json: @article.as_json
      # redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  
  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end