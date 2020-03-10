class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy] 
  # ↑自分の物か確認
  
  def index
  end

  def show
    @question = Question.find(params[:id])
    
    @answers = @question.answers.paginate(page: params[:page], per_page: 5).order('created_at desc')
    
    if logged_in?
      @answer = current_user.answers.build
    else
      @answer = Answer.new
    end
    
    question_counts(@question)
    
    @questions = Question.where(tag: @question.tag)
  end

  def new
  end

  def create
    @question = current_user.questions.build(question_params)
    @question.user_id = current_user.id

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
    redirect_to root_url
  end
  
  def search
    if params[:title].present?
      @content = params[:title]
      @tag = params[:tag]
      @created = params[:created_at]
      redirect_to result_path(title: @content, tag: @tag, period: @created)
    end
  end

  def result
    if params[:title].present?
      titles = params[:title].split(/[[:blank:]]+/).select(&:present?)
      
      negative_titles, positive_titles = titles.partition {|title| title.start_with?("-") }
        
      @questions = Question
      
      positive_titles.each do |title|
        @questions = @questions.where("title LIKE ?", "%#{title}%")
      end
      
      negative_titles.each {|word| word.slice!(/^-/) }
      
      negative_titles.each do |title|
        next if title.blank?
        @questions = @questions.where.not("title LIKE ?", "%#{title}%")
      end
      
      if params[:tag].present? && params[:tag] != "選択しない" 
        @questions = @questions.where("tag = ?", params[:tag])
      end
      
      search_date = Time.current
      
      if params[:period].present? && params[:period] != "選択しない" && params[:period] == "一年以内"
        @questions = @questions.where("? <= created_at", search_date - 1.years)
      elsif params[:period].present? && params[:period] != "選択しない" && params[:period] == "一ヶ月以内"
        @questions = @questions.where("? <= created_at", search_date - 1.months)
      elsif params[:period].present? && params[:period] != "選択しない" && params[:period] == "一週間以内"
        @questions = @questions.where("? <= created_at", search_date - 1.weeks )
      elsif params[:period].present? && params[:period] != "選択しない" && params[:period] == "一日以内"
        @questions = @questions.where("? <= created_at", search_date - 1.days )
      end
      
      @questions = @questions.page(params[:page]).per(5).order('created_at desc')
      @searchtext = 1
    else
      @questions = Question.none
    end
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
