class UsersController < ApplicationController
  
  before_action :authenticate_user, only: [:edit , :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
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
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
    def authenticate_user
      @user = User.find(params[:id])
      if @user == current_user
        else
      redirect_to root_path
      end
    end
  
end
