class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destroy]
  before_action :user_unlogged_in, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy] 

  def show
    @user = User.find(params[:id])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "アカウントを作成できました"
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = "アカウントを作成できませんでした"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    
    counts(@user)
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "プロフィールを変更しました"
      redirect_to @user
    else
      flash[:danger] = "プロフィールを変更できませんでした"
      render :edit
    end
  end

  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
    else
      @user = User.find_by(id: session[:user_id])
    end
    
    @user.destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to root_url
  end
  
  def post
    @user = User.find(params[:id])
    
    @posts = @user.questions.paginate(page: params[:page], per_page: 5).order('created_at desc')
    
     counts(@user)
  end
  
  def reply
    @user = User.find(params[:id])
    
    @replys = @user.answers.paginate(page: params[:page], per_page: 5).order('created_at desc')
  
    counts(@user)
  end
  
  def admin
    @admin = Admin.new
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)  
  end
  
  def correct_user
    if request.referer == nil
      redirect_to root_url
    end
  end
end
