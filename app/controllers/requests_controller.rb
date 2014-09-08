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
    	redirect_to root_path
    else
    	redirect_to root_path, notice: "Request failed - both fields must be filled"
    end

  end


  private
  def request_params
    params.require(:request).permit(:title, :requester)
  end


end
