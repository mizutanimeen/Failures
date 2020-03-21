class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private

  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def user_unlogged_in
    if logged_in?
      redirect_to root_path
    end
  end
  
  def counts(user)
    @count_questions = user.questions.count
    @count_answers = user.answers.count
  end
  
  def question_counts(question)
    @count_favoriters = question.favoriters.count
  end
  
  def micropost_counts(micropost)
    @count_micropost = micropost.count
  end
  
  def set_tags_paths
    @tags = ["その他", "人間関係", "恋愛", "仕事", "家庭", "学校", "勉強", "プログラミング", "美容", "遊び", "スポーツ", "ニュース"]
    @path = ["other", "human", "love", "work", "home", "school", "study", "programming", "beauty", "play", "sports", "news"]
  end
end
