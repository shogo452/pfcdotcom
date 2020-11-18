class Balance < ApplicationRecord
  belongs_to :user
  enum gender: [:noselect, :male, :female], _prefix: true
  enum activity: [:noselect, :low, :normal, :high], _prefix: true
  enum fitness_type: [:noselect, :diet, :keep, :bulkup], _prefix: true

  validates :height, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 250 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 150 }
  validates :gender, inclusion: { in: ["male","female"] }
  validates :fitness_type, inclusion: { in: ["diet","keep","bulkup"] }
  validates :activity, inclusion: { in: ["low","normal","high"] }

  before_save do
    # 基礎代謝の計算
    if self.gender == "male"
      self.basal_metabolism = (10 * self.weight) + (6.25 * self.height) - (5 * self.age) + 5
    else
      self.basal_metabolism = (10 * self.weight) + (6.25 * self.height) - (5 * self.age) - 161
    end

    # 活動代謝の計算
    if self.activity == "low"
      self.activity_metabolism = self.basal_metabolism * 1.2
    elsif self.activity == "normal"
      self.activity_metabolism = self.basal_metabolism * 1.55
    else
      self.activity_metabolism = self.basal_metabolism * 1.725
    end

    # 摂取カロリー
    if self.fitness_type == "diet"
      self.calory_intake = self.activity_metabolism * 0.8
    elsif self.fitness_type == "keep"
      self.calory_intake = self.activity_metabolism * 1
    else
      self.calory_intake = self.activity_metabolism * 1.2
    end

    # タンパク質の摂取量計算
    self.protein_intake = self.weight * 2 * 4
    # 脂質の摂取量計算
    self.fat_intake = (self.calory_intake * 0.25) / 4
    # 炭水化物の摂取量計算
    self.carbo_intake = (self.calory_intake - self.protein_intake - self.fat_intake) / 4
  end
end
