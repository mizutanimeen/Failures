class ToppagesController < ApplicationController
  def index
    if logged_in? 
      @question = current_user.questions.build
    end
    @questions = Question.page(params[:page]).per(5).order('created_at desc')
    
    @microposts = Micropost.page(params[:page]).per(3).order('created_at desc')
  end
  
  def ranking
    @rankings = Question.find(Favorite.group(:question_id).order('count(question_id) desc').limit(10).pluck(:question_id))
  end
end
