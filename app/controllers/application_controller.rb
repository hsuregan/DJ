class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def get_current_user
  	current_user
  end


  private
  def current_user
    if User.count != 0
  	   @current_user ||= User.find(session[:user_id]) if session[:user_id]
     end
  end
  helper_method :current_user



  def press_release
    @press_release = News.order(updated_at: :desc).limit(25)
  end
  helper_method :press_release
end

