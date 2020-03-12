class TagsController < ApplicationController
  def tag
    @questions = Question.all
  end
  
  def other
    @questions = Question.where(tag: "その他").page(params[:page]).per(10).order('created_at desc')
  end
  
  def human
    @questions = Question.where(tag: "人間関係").page(params[:page]).per(10).order('created_at desc')
  end
    
  def love
    @questions = Question.where(tag: "恋愛").page(params[:page]).per(10).order('created_at desc')
  end
  
  def work
    @questions = Question.where(tag: "仕事").page(params[:page]).per(10).order('created_at desc')
  end
  
  def home
    @questions = Question.where(tag: "家庭").page(params[:page]).per(10).order('created_at desc')
  end
  
  def school
    @questions = Question.where(tag: "学校").page(params[:page]).per(10).order('created_at desc')
  end
  
  def study
    @questions = Question.where(tag: "勉強").page(params[:page]).per(10).order('created_at desc')
  end
  
  def programming
    @questions = Question.where(tag: "プログラミング").page(params[:page]).per(10).order('created_at desc')
  end
  
  def beauty
    @questions = Question.where(tag: "美容").page(params[:page]).per(10).order('created_at desc')
  end
  
  def play
    @questions = Question.where(tag: "遊び").page(params[:page]).per(10).order('created_at desc')
  end
  
  def sports
    @questions = Question.where(tag: "遊び").page(params[:page]).per(10).order('created_at desc')
  end
  
  def news
    @questions = Question.where(tag: "ニュース").page(params[:page]).per(10).order('created_at desc')
  end
end
