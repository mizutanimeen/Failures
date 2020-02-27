class ToppagesController < ApplicationController
  def index
    if logged_in? 
      @question = current_user.questions.build
    end
    @questions = Question.order('created_at desc').page(params[:page])
  end
end
