# frozen_string_literal: true

class BalancesController < ApplicationController
  before_action :set_balance, only: [:update]

  def create
    @balance = Balance.new(balance_params)
    if @balance.save
      flash[:success] = 'データの更新が完了しました。'
      redirect_back(fallback_location: user_path(current_user))
    else
      redirect_back(fallback_location: user_path(current_user))
    end
  end

  def update
    @balance.update(balance_params)
    flash[:success] = 'データの更新が完了しました。'
    redirect_back(fallback_location: user_path(current_user))
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
