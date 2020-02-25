class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :edit]
  
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "アカウントを作成できました"
      redirect_to @user
    else
      flash.now[:danger] = "アカウントを作成できませんでした"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to root_url
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)  
  end
end
