# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user
  @datas = Record.all
  validates :date, presence: true
  validates :weight, presence: true, numericality: true
  validates :body_fat_percentage, numericality: true, allow_blank: true
end
