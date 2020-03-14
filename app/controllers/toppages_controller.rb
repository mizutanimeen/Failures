class ToppagesController < ApplicationController
  def index
    if logged_in? 
      @question = current_user.questions.build
    end
    @questions = Question.page(params[:page]).per(5).order('created_at desc')
    
    @microposts = Micropost.limit(3).order('created_at desc')
    @microposts_count = Micropost.all
    micropost_counts(@microposts_count)
  end
  
  def ranking
    @rankings = Question.find(Favorite.group(:question_id).order('count(question_id) desc').limit(10).pluck(:question_id))
  end
end
