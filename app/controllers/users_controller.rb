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
    @user = User.find(current_user)
    @title = @user.username + "'s statistics"
    @statistics = @user.statistics.order("created_at DESC")

    respond_to do |format|
      format.html { render "show" }
      format.json { render :json => @statistics }
    end
  end

  def show
    if params[:username]
      @user = User.find_by_username(params[:username])
    else
      @user = User.find(params[:id])
    end

    @statistics = @user.statistics.order("created_at DESC")
    @title = @user.username + "'s statistics"

    respond_to do |format|
      format.html
      format.json { render :json => @statistics }
    end
  end
end

