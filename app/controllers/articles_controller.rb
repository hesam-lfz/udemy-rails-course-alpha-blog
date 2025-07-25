class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end
  
  def index
    #@articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
        # render plain: @article.inspect
        # redirect_to article_path(@article)
        flash[:notice] = "Article created."
        redirect_to @article
    else
        render 'new'
    end
  end

  def edit
  end

  def update    
    if @article.update(article_params)
      flash[:notice] = "Article updated."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article    
    @article = Article.find(params['id'])
  end
  
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

end
