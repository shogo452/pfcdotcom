# frozen_string_literal: true

class BalancesController < ApplicationController
  before_action :set_balance, only: [:update]

  def create
    @balance = Balance.new(balance_params)
    if @balance.save
      flash[:success] = 'データの更新が完了しました。'
    else
      flash[:alert] = 'データの更新に失敗しました。'
    end
    redirect_to user_path(current_user)
  end

  def update
    if @balance.update(balance_params)
      flash[:success] = 'データの更新が完了しました。'
    else
      flash[:alert] = 'データの更新に失敗しました。'
    end
    redirect_to user_path(current_user)
  end

  private

    def balance_params
      params.require(:balance).permit(:gender, :height, :weight, :age, :fitness_type, :activity, :basal_metabolism,
                                      :protein_intake, :carbo_intake, :fat_intake, :prefecture_id).merge(user_id: current_user.id)
    end

    def set_balance
      @balance = Balance.find(params[:id])
    end
end
