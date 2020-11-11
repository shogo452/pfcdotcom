class Balance < ApplicationRecord
  belongs_to :user
  enum gender: [:noselect, :male, :female], _prefix: true
  enum activity: [:noselect, :low, :normal, :high], _prefix: true
  enum fitness_type: [:noselect, :diet, :keep, :bulkup], _prefix: true

  validates :height, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 250}
  validates :weight, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 200}
  validates :age, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 150}


  def set_extra_information
    binding.pry
    # 基礎代謝の計算
    if gender == "male"
      basal_metabolism = ( 10 * weight ) + ( 6.25 * height ) - ( 5 * age ) + 5
    else 
      basal_metabolism = ( 10 * weight ) + ( 6.25 * height ) - ( 5 * age ) - 161
    end

    # 活動代謝の計算
    if activity == "low"
      activity_metabolism = basal_metabolism * 1.2
    elsif activity == "normal"
      activity_metabolism = basal_metabolism * 1.55
    else
      activity_metabolism = basal_metabolism * 1.725
    end

    # 摂取カロリー
    if fitness_type == "diet"
      calory_intake = activity_metabolism * 0.8
    elsif fitness_type == "keep"
      calory_intake = activity_metabolism * 1
    else
      calory_intake = activity_metabolism * 1.2
    end

    # タンパク質の摂取量計算
    protein_intake = weight * 2 * 4
    # 脂質の摂取量計算
    fat_intake = ( calory_intake * 0.25 ) / 4
    # 炭水化物の摂取量計算
    carbo_intake = ( calory_intake - protein_intake - fat_intake ) / 4

    # 計算結果の反映
    {basal_metabolism: basal_metabolism, activity_metabolism: activity_metabolism, calory_intake: calory_intake, protein_intake: protein_intake, fat_intake: fat_intake, carbo_intake: carbo_intake}
  
  end
end
