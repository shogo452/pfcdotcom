class Product < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user
    
  mount_uploader :image, PictureUploader

  def new_arrival?
    created_at + 1.week > Date.today
  end

end
