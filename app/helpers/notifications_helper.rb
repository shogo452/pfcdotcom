module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @review = nil
    @room = nil
    your_item = link_to 'あなたの投稿', product_path(notification), style:"font-weight: bold;"
    room = link_to 'あなたにDM', room_path(notification), style:"font-weight: bold;"
    @visiter_review = notification.review_id
    @visiter_room = notification.room_id
    @message_id = notification.message_id
    case notification.action
    when "follow" then
      tag.a(notification.visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました。"
    when "like" then
      tag.a(notification.visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:product_path(notification.product_id), style:"font-weight: bold;")+"にいいねしました"
    when "favorite" then
      tag.a(notification.visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:product_path(notification.product_id), style:"font-weight: bold;")+"をお気に入りに登録しました"
    when "review" then
      @review = Review.find_by(id: @visiter_review)&.text
      tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:product_path(notification.product_id), style:"font-weight: bold;")+"にレビューを投稿しました"
    when "dm" then
      @room = Room.find_by(id: @visiter_room)
      @message = Message.find_by(id: @message_id)
      tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"から"+tag.a('ダイレクトメッセージ', href:room_path(notification.room_id), style:"font-weight: bold;")+"が届きました。"
    end
    
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
