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

def approve
	@concertreview = ConcertReview.find(params[:id])
		if (session[:user_id])
			@concertreview.approval = true;
			@concertreview.save
			UserMailer.article_email(@concertreview.email).deliver
			redirect_to root_path, notice: 'Article is Online'
		else
			redirect_to @article, notice: "No Access Rights"
		end
end

def deny
	@concertreview = ConcertReview.find(params[:id])
		if (session[:user_id])
			@concertreview.approval = false;
			@concertreview.save 
			redirect_to root_path, notice: 'Article has been taken Offline'
		else
			redirect_to @concertreview, notice: 'No Access Rights'
		end
end


def edit
		@concertreview = ConcertReview.find(params[:id])
		if session[:user_id] == nil
			redirect_to root_path, notice: "No Access Rights"
		end
	
		
		#return RedirectToAction("Index", model);

		#@article = Article.find(params[:id])
		
end

def update
		@concertreview = ConcertReview.find(params[:id])
		if (session[:user_id])
			if @concertreview.update(concertreview_params)
				@concertreview.save
				redirect_to root_path, notice: 'Article is Online'
			else
				render "edit"
			end
		else
			redirect_to @concertreview, notice: "No Access Rights"
			
		end
end


def destroy
        @concertreview = ConcertReview.find(params[:id])   
       	if session[:user_id]
       		@concertreview.delete
       		redirect_to action: "index"
       	else
			redirect_to @concertreview, notice: "No Access Rights"
       	end
  end

private

def concertreview_params
	params.require(:concert_review).permit(:title, :author, :email, :content, :image, :location, :artist_id)
end



def artist_params
	params.require(:artist).permit(:name)
end
end
