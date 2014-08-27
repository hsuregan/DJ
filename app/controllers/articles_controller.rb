class ArticlesController < ApplicationController

def index
	@articles = Article.order(updated_at: :desc).limit(25)
end

def new
	@article = Article.new
end

def create
	@article = Article.new(article_params)
	if @article.save
		redirect_to @article, notice: 'Your article has been published'
	else
		render "new"
	end
end

def show
	@article = Article.find(params[:id])
end

private

def article_params
	params.require(:article).permit(:title, :content)
end

end
