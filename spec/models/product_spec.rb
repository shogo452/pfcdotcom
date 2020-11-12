require 'rails_helper'
describe Product do
  describe '#create' do
    it "値が全て存在すれば登録できる" do
      product = build(:product)
      expect(product).to be_valid
    end

    it "nameが空では登録できないこと" do
      product = build(:product, name: "")
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "proteinが空では登録できないこと" do
      product = build(:product, protein: "")
      product.valid?
      expect(product.errors[:protein]).to include("を入力してください")
    end

    it "fatが空では登録できないこと" do
      product = build(:product, fat: "")
      product.valid?
      expect(product.errors[:fat]).to include("を入力してください")
    end

    it "carboが空では登録できないこと" do
      product = build(:product, carbo: "")
      product.valid?
      expect(product.errors[:carbo]).to include("を入力してください")
    end

    it "proteinが半角数字以外の文字では登録できないこと" do
      product = build(:product, protein: "３００")
      product.valid?
      expect(product).to be_invalid
    end

    it "proteinが999を超えたら登録できないこと" do
      product = build(:product, protein: "1000")
      product.valid?
      expect(product).to be_invalid
    end

    it "proteinが規定範囲内であれば登録できる" do
      product = build(:product, protein: "300")
      product.valid?
      expect(product).to be_valid
    end

    it "fatが半角数字以外の文字では登録できないこと" do
      product = build(:product, fat: "３００")
      product.valid?
      expect(product).to be_invalid
    end

    it "fatが999を超えたら登録できないこと" do
      product = build(:product, fat: "1000")
      product.valid?
      expect(product).to be_invalid
    end

    it "fatが規定範囲内であれば登録できる" do
      product = build(:product, fat: "300")
      product.valid?
      expect(product).to be_valid
    end

    it "carboが半角数字以外の文字では登録できないこと" do
      product = build(:product, carbo: "３００")
      product.valid?
      expect(product).to be_invalid
    end

    it "carboが999を超えたら登録できないこと" do
      product = build(:product, carbo: "1000")
      product.valid?
      expect(product).to be_invalid
    end

    it "carboが規定範囲内であれば登録できる" do
      product = build(:product, carbo: "300")
      product.valid?
      expect(product).to be_valid
    end

    it "sugarが半角数字以外の文字では登録できないこと" do
      product = build(:product, sugar: "３００")
      product.valid?
      expect(product).to be_invalid
    end

    it "sugarが999を超えたら登録できないこと" do
      product = build(:product, sugar: "1000")
      product.valid?
      expect(product).to be_invalid
    end

    it "sugarが規定範囲内であれば登録できる" do
      product = build(:product, sugar: "300")
      product.valid?
      expect(product).to be_valid
    end

    it "caloryが半角数字以外の文字では登録できないこと" do
      product = build(:product, calory: "３００")
      product.valid?
      expect(product).to be_invalid
    end

    it "caloryが9999を超えたら登録できないこと" do
      product = build(:product, calory: "10000")
      product.valid?
      expect(product).to be_invalid
    end

    it "caloryが規定範囲内であれば登録できる" do
      product = build(:product, calory: "300")
      product.valid?
      expect(product).to be_valid
    end

    it "purchase_urlが正しいフォーマット(http)であれば登録できる" do
      product = build(:product, purchase_url: "http://exmaple.com")
      product.valid?
      expect(product).to be_valid
    end

    it "purchase_urlが正しいフォーマット(https)であれば登録できる" do
      product = build(:product, purchase_url: "https://exmaple.co.jp")
      product.valid?
      expect(product).to be_valid
    end

    it "purchase_urlがフォーマット正しくなければ登録できないこと" do
      product = build(:product, purchase_url: "aaaaaaaaaaaaaa")
      product.valid?
      expect(product).to be_invalid
    end

  end
end
