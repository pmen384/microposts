class UsersController < ApplicationController
  before_action :collect_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page params[:page]
  end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    #@user = User.find(params[:id])
  end
  
  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user , notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "Followings"
    user = User.find(params[:id])
    @followings = user.following_users
  end
  
  def followers
    @title = "Followers"
    user = User.find(params[:id])
    @followers = user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location)
  end
  
  def collect_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
end