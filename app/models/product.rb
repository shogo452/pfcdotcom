class Product < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user
  has_many :notifications, dependent: :destroy

  mount_uploader :image, PictureUploader

  validates :name, presence: true
  validates :protein, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999 }
  validates :fat, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999 }
  validates :carbo, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999 }
  validates :sugar, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999 }
  validates :calory, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9999 }
  validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999 }
  validates :purchase_url, format: { with: URI.regexp(%w[http https]) }, allow_blank: true

  def new_arrival?
    created_at + 1.week > Date.today
  end

  def created_like_notification_by(current_user)
    notification = current_user.active_notifications.new(
      product_id: id,
      visited_id: user_id,
      action: "like",
    )
    notification.save if notification.valid?
  end

  def created_favorite_notification_by(current_user)
    notification = current_user.active_notifications.new(
      product_id: id,
      visited_id: user_id,
      action: "favorite",
    )
    notification.save if notification.valid?
  end

  def create_notification_review!(current_user, review_id)
    temp_ids = Review.select(:user_id).where(product_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_review!(current_user, review_id, temp_id["user_id"])
    end
    save_notification_review!(current_user, review_id, user_id) if temp_ids.blank?
  end

  def save_notification_review!(current_user, review_id, visited_id)
    notification = current_user.active_notifications.new(
      product_id: id,
      review_id: review_id,
      visited_id: visited_id,
      action: "review",
    )
    if notification.visiter_id == notification.visited_id
      notification.checked == true
    end
    notification.save if notification.valid?
  end

  scope :search_product, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name])
  end
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
end
