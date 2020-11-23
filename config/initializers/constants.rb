module TagValue
  LINK_TO_VISITER = 'notification.visiter.nickname, href: user_path(@visiter), style: "font-weight: bold;"'.freeze
  LINK_TO_AUTHOR = '@visiter.nickname href: user_path(@visiter), style: "font-weight: bold;"'.freeze
  LINK_TO_PRODUCT = '"あなたの投稿", href: product_path(notification.product_id), style: "font-weight: bold;"'.freeze
  LINK_TO_DM = '"ダイレクトメッセージ", href: room_path(notification.room_id), style: "font-weight: bold;"'.freeze
end