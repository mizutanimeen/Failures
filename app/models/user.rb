class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password
  
  has_many :questions
  has_many :questions, dependent: :destroy 
  
  has_many :answers
  
  has_many :microposts
  
  mount_uploader :picture, PictureUploader

  has_many :favorites
  has_many :favorites, dependent: :destroy 
  has_many :favoritings, through: :favorites, source: :question
  
  def favorite(question)
    unless self == question
      self.favorites.find_or_create_by(question_id: question.id)
    end
  end

  def unfavorite(question)
    favorite = self.favorites.find_by(question_id: question.id)
    favorite.destroy if favorite
  end

  def favoritings?(question)
    self.favoritings.include?(question)
  end
  
end
