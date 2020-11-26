# frozen_string_literal: true

require 'rails_helper'
describe Record do
  describe '#create' do
    it '値が全て存在すれば登録できる' do
      record = build(:record)
      expect(record).to be_valid
    end

    it 'dateが空では登録できないこと' do
      record = build(:record, date: '')
      record.valid?
      expect(record.errors[:date]).to include('を入力してください')
    end

    it 'weightが空では登録できないこと' do
      record = build(:record, weight: '')
      record.valid?
      expect(record.errors[:weight]).to include('を入力してください')
    end

    it 'weightが数字以外の場合は登録できないこと' do
      record = build(:record, weight: 'aaa')
      record.valid?
      expect(record.errors[:weight]).to include('は数値で入力してください')
    end

    it 'bofy_fat_percentageが数字以外の場合は登録できないこと' do
      record = build(:record, body_fat_percentage: 'aaa')
      record.valid?
      expect(record.errors[:body_fat_percentage]).to include('は数値で入力してください')
    end
  end
end
