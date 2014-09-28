class SessionsController < ApplicationController
  def new
      render layout: false
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to root_path, notice: "Logged in"
  	else
  		flash.now.alert = "Email or Password is invalid"
  		render "new"
  	end
  end

 


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "logged out"
  end


end
