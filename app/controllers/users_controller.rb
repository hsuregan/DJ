class UsersController < ApplicationController

def new
	if (current_user != nil && current_user.admin == true) || User.count == 0
		@user = User.new
		@accounts = User.all
	else
		redirect_to root_path
	end
end

def create
	@user = User.new(user_params)
	if(User.count != 0)
		@user.added_by = current_user.name
		@user.added_by_email = current_user.email
	end

	if @user.save
		redirect_to root_path, notice: "Thank you for signing up"
	else
		render "new"
	end
end

def destroy
	# if user is admin !!!!
	@user = User.find(params[:id])   
	@user.delete
	redirect_to action: "new"
end

private

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation, :admin)
	end

end
