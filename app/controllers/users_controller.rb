class UsersController < ApplicationController
  def show
    @user = User.with_attached_avatar.find(params[:id])
    unless @balance = @user.balance
      @user.build_balance
      @user.balance.protein_intake = 0
      @user.balance.fat_intake = 0
      @user.balance.carbo_intake = 0
      @user.balance.save
    end
    @balance = @user.balance
    @record = Record.new
    @records = @user.records.order("date DESC").page(params[:page]).per(4)
    @record_datas = Record.where(user_id: current_user.id).order("date ASC")
    @weights = @record_datas.map(&:weight)
    @dates = @record_datas.map { |record_data| record_data.date.strftime("%Y/%m/%d") }
    @body_fat_percentages = @record_datas.map(&:body_fat_percentage)
    @prefecture = Prefecture.find(@user.balance.prefecture_id.to_i)
  end

  def index
    @users = User.with_attached_avatar
    @user = User.new
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(5)
    render 'index'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(5)
    render 'index'
  end




  
end
