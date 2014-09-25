class RequestsController < ApplicationController

  def index
    if current_user == nil
      redirect_to root_path
    else
      @requests = Request.order(updated_at: :asc)
    end
  end



  def create
  	@request = Request.new(request_params)
  	if @request.save
      UserMailer.recieved_request(@request.email).deliver
    	redirect_to root_path, notice: "An Email Confirmation Was Sent To You.  Reply 'Approve' To Authenticate Request."
    else
    	redirect_to root_path, notice: "Request failed - all fields must be filled"
    end

  end


  private
  def request_params
    params.require(:request).permit(:title, :requester, :email)
  end


end
