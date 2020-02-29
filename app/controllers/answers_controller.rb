class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id

    if @answer.save
      flash[:success] = "返信しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "返信に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @answer = Answer.find_by(id: params[:id])
    
    @answer.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  
  private
  
  def answer_params
    params.require(:answer).permit(:content).merge(user_id: current_user.id, question_id: params[:question_id])
  end
end
