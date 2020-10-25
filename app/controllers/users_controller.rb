class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless @balance = @user.balance
      @user.build_balance
      @user.balance.protein_intake = 0
      @user.balance.fat_intake = 0
      @user.balance.carbo_intake = 0
      @user.balance.save
    end
    @balance = @user.balance
  end
end
