# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @room = @message.room
      if @message.save
        @room_member_not_me = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
        @other_member = @room_member_not_me.find_by(room_id: @room.id)
        notification = current_user.active_notifications.new(
          room_id: @room.id,
          message_id: @message.id,
          visited_id: @other_member.user_id,
          visiter_id: current_user.id,
          action: 'dm'
        )
        notification.save if notification.valid?
        redirect_to "/rooms/#{@message.room_id}"
      end
    else
      flash[:alert] = 'メッセージ送信に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def message_params
      params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
    end
end
