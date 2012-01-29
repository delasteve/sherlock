class UsersController < ApplicationController
  before_filter :authenticate,  :only => [:index, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url
    else
      render "new"
    end
  end

  def index
    @user = User.includes(:statistics => :hourly_statistic).find(current_user)
    @title = @user.username + "'s statistics"

    respond_to do |format|
      format.html { render "show" }
      format.json { render :json => @user.statistics }
    end
  end

  def show
    if params[:username]
      @user = User.includes(:statistics => :hourly_statistic).find_by_username(params[:username])
    else
      @user = User.includes(:statistics => :hourly_statistic).find(params[:id])
    end

    @title = @user.username + "'s statistics"

    respond_to do |format|
      format.html
      format.json { render :json => @user.statistics }
    end
  end
end

