class SessionsController < ApplicationController
	def new
    if signed_in?
      redirect_to(root_path)
    end
  end

  def create
  	user = User.find_by_username(params[:session][:username].downcase)
  	if user && user.authenticate(params[:session][:password])
    	sign_in user
      redirect_back_or user
  	else
    	flash.now[:error] = 'Invalid username/password combination'
      render 'new'
  	end
  end

  def destroy
    sign_out
    redirect_to forums_url
  end
end
