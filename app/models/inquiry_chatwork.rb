# frozen_string_literal: true

class InquiryChatwork
  require 'net/https'
  require 'json'

  def push_chatwork_message(inquiry)
    @inquiry = inquiry
    @uri = URI.parse('https://api.chatwork.com')
    @client = Net::HTTP.new(@uri.host, 443)
    @client.use_ssl = true

    @chatwork_api_token = ENV['CHATWORK_API_TOKEN']
    @message_room_id = ENV['CHATWORK_ROOM_ID']
    @message_title = ' PFC.comの問い合わせフォームから問い合わせがありました。問い合わせ内容をChatWorkへ通知します。'
    @message_text = '[info][title]' << @message_title << '[/title]'
    @message_text = @message_text << @inquiry.name << "\n" << @inquiry.email << "\n" << @inquiry.message << '[/info]'

    @res = @client.post("/v2/rooms/#{@message_room_id}/messages", "body=#{@message_text}", { 'X-ChatWorkToken' => @chatwork_api_token.to_s })
    puts JSON.parse(@res.body)
  end
end
