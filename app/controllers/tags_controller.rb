class TagsController < ApplicationController
  def tag
    @questions = Question.all
    set_tags_paths
  end
  
  def other
    set_tag(0)
  end
  
  def human
    set_tag(1)
  end
    
  def love
    set_tag(2)
  end
  
  def work
    set_tag(3)
  end
  
  def home
    set_tag(4)
  end
  
  def school
    set_tag(5)
  end
  
  def study
    set_tag(6)
  end
  
  def programming
    set_tag(7)
  end
  
  def beauty
    set_tag(8)
  end
  
  def play
    set_tag(9)
  end
  
  def sports
    set_tag(10)
  end
  
  def news
    set_tag(11)
  end
  
  
  private
  
  
  def set_tag(number)
    @tags = ["その他", "人間関係", "恋愛", "仕事", "家庭", "学校", "勉強", "プログラミング", "美容", "遊び", "スポーツ", "ニュース"]
    @questions = Question.where(tag: @tags[number]).page(params[:page]).per(10).order('created_at desc')
    @tag = @tags[number]
  end
end
