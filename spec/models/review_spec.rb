require 'rails_helper'

describe Review do
  describe '#create' do
    it "値が存在すれば登録できる" do
      review = build(:review)
      expect(review).to be_valid
    end

    it "値が空では登録できないこと" do
      review = build(:review, rate: "")
      review.valid?
      expect(review.errors[:rate]).to include("を入力してください")
    end

    it "値が5以上では登録できないこと" do
      review = build(:review, rate: 6)
      review.valid?
      expect(review.errors[:rate]).to include("は5以下の値にしてください")
    end

    it "値が1以下では登録できないこと" do
      review = build(:review, rate: 0)
      review.valid?
      expect(review.errors[:rate]).to include("は1以上の値にしてください")
    end

  end
end
