class MicropostsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :create, :destroy]
  before_action :admin?, only: [:index, :create, :destroy]
  
  def index
    @micropost = current_user.microposts.build
  end
  
  def show
    @micropost = Micropost.find(params[:id])
  end
  
  def new
    @microposts = Micropost.page(params[:page]).per(5).order('created_at desc')
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    
    if @micropost.save
      flash[:success] = 'お知らせを投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'お知らせの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    
    @micropost.destroy
    flash[:success] = 'お知らせを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def admin?
    redirect_to root_url unless current_user.admin?
  end
  
  def micropost_params
    params.require(:micropost).permit(:title, :content)
  end
end
