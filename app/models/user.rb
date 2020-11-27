# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_one :balance, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :area, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product
  has_many :favorites, dependent: :destroy
  has_many :favproducts, through: :favorites, source: :product
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entry, dependent: :destroy

  enum gender: { noselect: 0, male: 1, female: 2 }, _prefix: true
  enum activity: { noselect: 0, low: 1, normal: 2, high: 3 }, _prefix: true
  enum fitness_type: { noselect: 0, diet: 1, keep: 2, bulkup: 3 }, _prefix: true
  enum role: { user: 0, admin: 1 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :nickname, presence: true

  def already_liked?(product)
    likes.exists?(product_id: product.id)
  end

  def like(product)
    favorites.find_or_create_by(product_id: product.id)
  end

  def unlike(product)
    favorite = favorites.find_by(product_id: product.id)
    favorite&.destroy
  end

  def favproduct?(product)
    favorites.exists?(product_id: product.id)
  end

  def follow(other_user)
    relationships.create(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(['visited_id = ? and visited_id = ? and action = ?', current_user.id, id, 'follow'])
    return if temp.present?

    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end
end
