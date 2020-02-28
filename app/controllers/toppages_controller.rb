class ToppagesController < ApplicationController
  def index
    if logged_in? 
      @question = current_user.questions.build
    end
    @questions = Question.page(params[:page]).per(5).order('created_at desc')
  end
end
