class Product < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags
    
  mount_uploader :image, PictureUploader

  def new_arrival?
    created_at + 1.week > Date.today
  end

end
