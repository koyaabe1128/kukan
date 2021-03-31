class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index, :show, :edit, :destroy, :password_resets, :setting, :withdrawal]
  before_action :correct_user, only: [:edit, :update, :destroy, :password_resets, :setting, :withdrawal]
  
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_profile_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
  end
  
  def followings
    @user = User.find(params[:id])
  end
  
  def likes
    @user = User.find(params[:id])
  end
  
  def setting
    @user = User.find(params[:id])
  end
    
  def password_resets
    @user = User.find(params[:id])
  end
  
  def withdrawal
    @user = User.find(params[:id])
  end
  
  def search
  end
  
  private
  
  #Strong Parameter
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_profile_params
    params.require(:user).permit(:name, :image, :introduction, :genre, :prefecture)
  end
  
  #本人か確認する
  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user.id == @user.id
  end
end
