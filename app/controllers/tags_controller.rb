class TagsController < ApplicationController
  def tag
    @questions = Question.all
  end
  
  def other
    @questions = Question.where(tag: "その他").page(params[:page]).per(10).order('created_at desc')
  end
  
  def work
    @questions = Question.where(tag: "仕事").page(params[:page]).per(10).order('created_at desc')
  end
  
  def home
    @questions = Question.where(tag: "家庭").page(params[:page]).per(10).order('created_at desc')
  end
  
end
