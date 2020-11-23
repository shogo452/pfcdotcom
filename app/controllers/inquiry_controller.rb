class InquiryController < ApplicationController
  before_action :set_flag_no_footer
  def index
    @inquiry = Inquiry.new
    render action: "index"
  end

  def confirm
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    if @inquiry.valid?
      render action: "confirm"
    else
      render action: "index"
    end
  end

  def thanks
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    InquiryMailer.received_email(@inquiry).deliver
    @chatwork = InquiryChatwork.new
    @chatwork.push_chatwork_message(@inquiry)
    render action: "thanks"
  end

  def set_flag_no_footer
    @flag = true
  end
end
