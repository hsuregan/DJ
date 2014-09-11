class UsersController < ApplicationController

def new
	if current_user != nil && current_user.email == "hsuregan@gmail.com"
		@user = User.new
	else
		redirect_to root_path
	end
end

def create
	@user = User.new(user_params)
	if @user.save
		UserMailer.welcome_email(@user).deliver
		redirect_to root_path, notice: "Thank you for signing up"
	else
		render "new"
	end
end

private

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end

end
