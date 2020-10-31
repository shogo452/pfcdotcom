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

  enum gender: [:noselect, :male, :female], _prefix: true
  enum activity: [:noselect, :low, :normal, :high], _prefix: true
  enum fitness_type: [:noselect, :diet, :keep, :bulkup], _prefix: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

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

end