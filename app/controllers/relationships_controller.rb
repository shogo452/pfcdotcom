class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:follow_id])
    if current_user.follow(@user)
      flash[:success] = 'ユーザーをフォローしました。'
      @user.create_notification_follow!(current_user)
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'ユーザーのフォローに失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @user = User.find(params[:relationship][:follow_id])
    if current_user.unfollow(@user)
      flash[:success] = 'ユーザーのフォローを解除しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'ユーザーのフォロー解除に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

end
