class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_one :balance, dependent: :destroy
  has_one_attached :avatar
  has_many :records, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :area
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product
  has_many :favorites, dependent: :destroy
  has_many :favproducts, through: :favorites, source: :product
  has_many :relationships, foreign_key: "user_id"
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entry, dependent: :destroy

  enum gender: [:noselect, :male, :female], _prefix: true
  enum activity: [:noselect, :low, :normal, :high], _prefix: true
  enum fitness_type: [:noselect, :diet, :keep, :bulkup], _prefix: true
  enum role: { user: 0, admin: 1 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :nickname, presence: true

  def already_liked?(product)
    self.likes.exists?(product_id: product.id)
  end

  def like(product)
    favorites.find_or_create_by(product_id: product.id)
  end

  def unlike(product)
    favorite = favorites.find_by(product_id: product.id)
    favorite.destroy if favorite
  end

  def favproduct?(product)
    self.favorites.exists?(product_id: product.id)
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.create(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visited_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow",
      )
      notification.save if notification.valid?
    end
  end
end
