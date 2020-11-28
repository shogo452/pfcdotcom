# frozen_string_literal: true

class Balance < ApplicationRecord
  belongs_to :user
  enum gender: { noselect: 0, male: 1, female: 2 }, _prefix: true
  enum activity: { noselect: 0, low: 1, normal: 2, high: 3 }, _prefix: true
  enum fitness_type: { noselect: 0, diet: 1, keep: 2, bulkup: 3 }, _prefix: true

  validates :height, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 250 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 150 }
  validates :gender, inclusion: { in: %w[male female] }
  validates :fitness_type, inclusion: { in: %w[diet keep bulkup] }
  validates :activity, inclusion: { in: %w[low normal high] }

  before_save do
    # 基礎代謝の計算
    self.basal_metabolism = if gender == 'male'
                              (10 * weight) + (6.25 * height) - (5 * age) + 5
                            else
                              (10 * weight) + (6.25 * height) - (5 * age) - 161
                            end

    # 活動代謝の計算
    self.activity_metabolism = case activity
                               when 'low'
                                 basal_metabolism * 1.2
                               when 'normal'
                                 basal_metabolism * 1.55
                               else
                                 basal_metabolism * 1.725
                               end

    # 摂取カロリー
    self.calory_intake = case fitness_type
                         when 'diet'
                           activity_metabolism * 0.8
                         when 'keep'
                           activity_metabolism * 1
                         else
                           activity_metabolism * 1.2
                         end

    # タンパク質の摂取量計算
    self.protein_intake = weight * 2 * 4
    # 脂質の摂取量計算
    self.fat_intake = (calory_intake * 0.25) / 4
    # 炭水化物の摂取量計算
    self.carbo_intake = (calory_intake - protein_intake - fat_intake) / 4
  end
end
