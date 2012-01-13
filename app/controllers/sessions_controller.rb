class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to my_stats_path
    else
      @title = "Log in"
    end
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      log_in user
      redirect_back_or user
    else
      flash.now.alert = "Invalid username or password."
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end

