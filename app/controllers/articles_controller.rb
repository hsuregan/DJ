class ArticlesController < ApplicationController

def index
	@articles = Article.order(updated_at: :desc).limit(25)
end

def new
	@article = Article.new
	@album = Album.new
	@artist = Artist.new
end

def create
	@album = Album.new(album_params)
	@artist = Artist.new(artist_params)
	@article = Article.new(article_params)

	if (@article.save && @album.save && @artist.save)	
		@article.artist = @artist
		@article.album = @album
		@article.save
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
	params.require(:article).permit(:title, :content, :content, :artist_ids, :album_ids, :rating, :year)
end

def album_params
	params.require(:album).permit(:title)
end

def artist_params
	params.require(:artist).permit(:name)
end
end

