class BalancesController < ApplicationController
  def new
    @balance = Balance.new
  end

  def create
    @balance = Balance.new(balance_information)
    if @balance.save
      flash[:success] = "PFCバランスの計算が完了しました。"
      redirect_back(fallback_location: user_path(current_user))
    else
      redirect_back(fallback_location: user_path(current_user))
    end
  end

  def edit
    @balance = Balance.find(params[:id])
  end

  def update
    @balance = Balance.find(params[:id])
    @balance.update(balance_params)
    @balance.update(balance_information)
    flash[:notice] = "PFCバランスの再計算が完了しました。"
    redirect_back(fallback_location: user_path(current_user))
    end

  private
  def balance_params
    params.require(:balance).permit(:gender, :height, :weight, :age, :fitness_type, :activity, :basal_metabolism, :protein_intake, :carbo_intake, :fat_intake).merge(user_id: current_user.id)
  end

  def balance_information
    balance_params.merge(@balance.set_extra_information)
  end
end
