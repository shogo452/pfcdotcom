class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_one :balance, dependent: :destroy
  has_one_attached :avatar

  enum gender: [:noselect, :male, :female], _prefix: true
  enum activity: [:noselect, :low, :normal, :high], _prefix: true
  enum fitness_type: [:noselect, :diet, :keep, :bulkup], _prefix: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecure


end