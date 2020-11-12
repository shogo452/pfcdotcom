require 'rails_helper'

describe Inquiry do
  describe '#input' do
    it "値が存在する場合、有効である" do
      inquiry = build(:inquiry)
      expect(inquiry).to be_valid
    end

    it "名前が未入力の場合、有効ではない" do
      inquiry = build(:inquiry, name: "")
      inquiry.valid?
      expect(inquiry.errors[:name]).to include("名前を入力しください")
    end

    it "メールアドレスが未入力の場合、有効ではない" do
      inquiry = build(:inquiry, email: "")
      inquiry.valid?
      expect(inquiry.errors[:email]).to include("メールアドレスを入力しください")
    end

  end
end

