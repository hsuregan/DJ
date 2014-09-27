class ConcertReviewsController < ApplicationController
	def index
		
	end

def new
	@concertreview = ConcertReview.new
	@artist = Artist.new
	@artistNames = []
	artists = Artist.all
	artists.each do |artist|
		@artistNames.push(artist.name)
	end

end

def create
	
	@artist = Artist.new(artist_params)
	@artist.name = @artist.name.split.map(&:capitalize).join(' ').rstrip.lstrip

	if(Artist.where(:name => @artist.name).count == 0)
		@artist.save
	else
		@artist = Artist.where(:name => @artist.name)[0]
	end

	@concertreview = ConcertReview.new(concertreview_params)

	if (@concertreview.save)
		UserMailer.written_article.deliver	
		@concertreview.artist = @artist
		@concertreview.save
		redirect_to root_path, notice: 'Your Article is Pending for Review.  An email will be conveyed if we think it is right for our site!'
	else
		render "new"
	end
end

def show
	@concertreview = ConcertReview.find(params[:id])
	render layout: false
end



private

def concertreview_params
	params.require(:concert_review).permit(:title, :author, :email, :content, :image, :location, :artist_id)
end



def artist_params
	params.require(:artist).permit(:name)
end
end
