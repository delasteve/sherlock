class UsersController < ApplicationController
  before_filter :login_required, :only => :index

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
    @statistics = @user.statistics.select("upload, download, post_count, seeding, created_at")
                                                    .order("created_at DESC")

    respond_to do |format|
      format.html
      format.json  { render :json => @statistics }
    end
  end

  def show
    if params[:username]
      @user = User.find_by_username(params[:username])
      @statistics = @user.statistics.order("created_at DESC")
    else
      @user = User.find(params[:id])
      @statistics = @user.statistics.order("created_at DESC")
    end

    respond_to do |format|
      format.html
      format.json  { render :json => @statistics }
    end
  end

  private
  def login_required
    unless current_user
      flash[:error] = 'You must be logged in to view this page.'
      redirect_to log_in_path
    end
  end
end

