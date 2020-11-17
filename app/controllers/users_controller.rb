class UsersController < ApplicationController
  def show
    @user = User.includes(:balance).includes(:records).with_attached_avatar.find(params[:id])
    unless @user.balance
      @balance = @user.build_balance
      @balance.protein_intake = 0
      @balance.fat_intake = 0
      @balance.carbo_intake = 0
      @balance.save
    else
      @balance = @user.balance
    end
    @record = Record.new
    @records = @user.records.order("date DESC").page(params[:page]).per(4)
    @record_datas = @user.records.order("date ASC")
    gon.weights = @record_datas.pluck(:weight)
    gon.dates = @record_datas.map { |record_data| record_data.date.strftime('%Y/%m/%d') }
    gon.body_fat_percentages = @record_datas.pluck(:body_fat_percentage)
    @prefecture = Prefecture.find(@user.balance.prefecture_id.to_i)
    @products = Product.all.includes(:users).includes(:reviews)
    @same_user_products = @products.where(user_id: @user.id).page(params[:page]).per(4)
    @user_favproducts = @user.favproducts.page(params[:page]).per(4)
    @user_liked_products = @user.liked_products.page(params[:page]).per(4)
    @rates = Review.group(:product_id).average(:rate)
    @likes_ranking = @products.order(likes_count: "DESC").limit(3)
    @favorites_ranking = @products.order(favorites_count: "DESC").limit(3)
    @user_followings = @user.followings.page(params[:page]).per(6)
    @user_followers = @user.followers.page(params[:page]).per(6)
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id
            @is_room = true
            @room_id = cu.room_id
            @room = Room.find(@room_id)
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def index
    @users = User.with_attached_avatar
    @user = User.new
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(5)
    render "index"
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(5)
    render "index"
  end
end
