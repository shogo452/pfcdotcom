class Product < ApplicationRecord
  belongs_to :user
    
  mount_uploader :image, PictureUploader

  def new_arrival?
    created_at + 1.week > Date.today
  end

end
