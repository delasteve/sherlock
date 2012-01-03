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
    @statistics = User.find(current_user).statistics.select(:upload)
                                                    .select(:download)
                                                    .select(:post_count)
                                                    .select(:uploaded)
                                                    .select(:seeding)

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

