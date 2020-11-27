# frozen_string_literal: true

module NotificationsHelper
  def notice_form(notification)
    @visiter = notification.visiter
    @review = nil
    @room = nil
    @visiter_review = notification.review_id
    @visiter_room = notification.room_id
    @message_id = notification.message_id
    case notification.action
    when 'follow'
      "#{tag.a(TagValue::LINK_TO_VISITER)}があなたをフォローしました。"
    when 'like'
      "#{tag.a(TagValue::LINK_TO_VISITER)}が#{tag.a(TagValue::LINK_TO_PRODUCT)}にいいねしました"
    when 'favorite'
      "#{tag.a(TagValue::LINK_TO_VISITER)}が#{tag.a(TagValue::LINK_TO_PRODUCT)}をお気に入りに登録しました"
    when 'review'
      @review = Review.find_by(id: @visiter_review)&.text
      "#{tag.a(TagValue::LINK_TO_AUTHOR)}が#{tag.a(TagValue::LINK_TO_PRODUCT)}にレビューを投稿しました"
    when 'dm'
      @room = Room.find_by(id: @visiter_room)
      @message = Message.find_by(id: @message_id)
      "#{tag.a(TagValue::LINK_TO_AUTHOR)}から#{tag.a(TagValue::LINK_TO_DM)}が届きました。"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
