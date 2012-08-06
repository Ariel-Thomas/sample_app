class SessionsController < ApplicationController

  def new
    if signed_in?
      redirect_to root_path and return
    end
  end

  def create
    if signed_in?
      redirect_to root_path and return
    end
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
