class ArticlesController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
    @article = Article.new
  end

  def new
  end

  def show
    @article = Article.find(params[:id])
    @newarticle = Article.new
    @article_comment = ArticleComment.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to article_path(@article), notice: "You have created book successfully."
    else
      @articles = Article.all
      render "index"
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def correct_user
    @article = Article.find(params[:id])
    @user = @article.user
    redirect_to(articles_path) unless @user == current_user
  end

end
