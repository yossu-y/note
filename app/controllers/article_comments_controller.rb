class ArticleCommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @article_comment = current_user.article_comments.new(article_comment_params)
    @article_comment.article_id = @article.id
    if @article_comment.save
      redirect_to article_path(@article), notice: "記事が公開されました。"
    else
      redirect_to article_path(@article), notice: "comment can't be blank"
    end
  end

  def destroy
    ArticleComment.find(params[:id]).destroy
    redirect_to article_path(params[:article_id])
  end

  private

  def article_comment_params
    params.require(:article_comment).permit(:comment)
  end
  
  def correct_user
    @article_comment = ArticleComment.find(params[:id])
    @user = @article_comment.user
    unless @user == current_user
      redirect_to article_path(params[:article_id])
    end
  end
end
