class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy] 
  # ↑自分の物か確認
  
  def index
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
  end

  def create
    @question = current_user.questions.build(question_params)
    
    if @question.save
      flash[:success] = "メッセージを投稿しました"
      redirect_to @question
    else
      flash[:danger] = "メッセージを投稿できませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @question.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  
  private
  
  
  def question_params
    params.require(:question).permit(:title, :content, :tag)
  end
  
  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_to root_url
    end
  end
end
