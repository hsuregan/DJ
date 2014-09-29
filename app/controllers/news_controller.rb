class NewsController < ApplicationController

	def index
		@news = News.all.order(created_at: :desc)
	end

	def new
		if(current_user.admin)
			@new = News.new
		else
			redirect_to root_path
		end
		
	end

	def create
		@new = News.new(news_params)
		if(current_user == nil)
			redirect_to root_path, notice: 'Access Denied'
		elsif(current_user.email == "hsuregan@gmail.com")
			if(@new.save)
				redirect_to root_path, notice: 'new press release has been posted'
			end
		else
			redirect_to root_path, notice: 'Access Denied'
		end


	end

	def show
		@new = News.find(params[:id])
		render layout: false
	end

	private

	def news_params
		params.require(:news).permit(:title, :content)
	end
end
