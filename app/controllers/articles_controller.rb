class ArticlesController < ApplicationController

def index
       # @item_album_artwork = @itunes.music("#{@track.artist} #{@track.title}").results.first.artwork_url100
	if params[:search] && (Article.search_by(params[:search]).count != 0)
		@articles = Article.search_by(params[:search])
	else
		@articles = Article.order(updated_at: :desc)
	end
end

def new
	@article = Article.new
	@album = Album.new
	@artist = Artist.new
	
	@albumTitles = []
	@artistNames = []
	albums = Album.all
	albums.each do |album|
		@albumTitles.push(album.title)
	end
	
	artists = Artist.all
	artists.each do |artist|
		@artistNames.push(artist.name)
	end

end

def create
	@album = Album.new(album_params)
	@album.title = @album.title.split.map(&:capitalize).join(' ').rstrip.lstrip
	
	@artist = Artist.new(artist_params)
	@artist.name = @artist.name.split.map(&:capitalize).join(' ').rstrip.lstrip

	if(Artist.where(:name => @artist.name).count == 0)
		UserMailer.written_article.deliver
		@artist.save
	else
		@artist = Artist.where(:name => @artist.name)[0]
	end

	if (Album.where(:title => @album.title).count == 0)
		@album.artist = @artist
		@album.save
	else
		@album = Album.where(:title => @album.title)[0]
	end

	@article = Article.new(article_params)

	if (@article.save)	
		@article.artist = @artist
		@article.album = @album
		@article.save
		redirect_to root_path, notice: 'Your Article is Pending for Review.  An email will be conveyed if we think it is right for our site!'
	else
		render "new"
	end
end

def show
	@article = Article.find(params[:id])
	render layout: false

end

def edit
		@article = Article.find(params[:id])
		if session[:user_id] == nil
			redirect_to root_path, notice: "No Access Rights"
		end
	
		
		#return RedirectToAction("Index", model);

		#@article = Article.find(params[:id])
		
end

def update
		@article = Article.find(params[:id])
		if (session[:user_id])
			if @article.update(article_params)
				@article.save
				redirect_to root_path, notice: 'Article is Online'
			else
				render "edit"
			end
		else
			redirect_to @article, notice: "No Access Rights"
			
		end
end

def approve
	@article = Article.find(params[:id])
		if (session[:user_id])
			@article.approval = true;
			@article.save
			UserMailer.article_email(@article.email).deliver
			redirect_to root_path, notice: 'Article is Online'
		else
			redirect_to @article, notice: "No Access Rights"
		end
end

def destroy
        @article = Article.find(params[:id])   
       	if session[:user_id]
       		@article.delete
       		redirect_to action: "index"
       	else
			redirect_to @article, notice: "No Access Rights"
       	end
  end


private

def article_params
	params.require(:article).permit(:author, :email, :content, :image, :artist_ids, :album_ids, :rating)
end



def album_params
	params.require(:album).permit(:title, :genre, :year)
end

def artist_params
	params.require(:artist).permit(:name)
end
end

