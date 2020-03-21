class Question < ApplicationRecord
  is_impressionable

  validates :title, presence: true, length: { maximum: 50 }
  validates :tag, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 1000 }
  
  belongs_to :user
  has_many :answers
  has_many :answers, dependent: :destroy 
  
  has_many :favorites
  has_many :favorites, dependent: :destroy
  has_many :favoriters, through: :favorites, source: :user
  
end