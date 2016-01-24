class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  before_action :authenticate_user, only: [:edit , :update, :following, :followers]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Wellcome to the Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def following
      @title = "Following"
      @user  = User.find(params[:id])
      @users = @user.following_users(page:params[:page])
      render 'show_following'
  end

  def followers
      @title = "Followers"
      @user  = User.find(params[:id])
      @users = @user.follower_users(page:params[:page])
      render 'show_follower'
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
      
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:about,:password,:password_confirmation)
  end
  
    def authenticate_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to root_path
      end
    end
end
