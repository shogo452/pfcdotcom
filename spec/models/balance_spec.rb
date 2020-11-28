# frozen_string_literal: true

require 'rails_helper'

describe Balance do
  describe '#create' do
    it '値が全て存在すれば登録できる' do
      balance = build(:balance)
      expect(balance).to be_valid
    end

    it 'genderが未選択では登録できないこと' do
      balance = build(:balance, gender: 0)
      balance.valid?
      expect(balance.errors[:gender]).to include('は一覧にありません')
    end

    it 'heightが空では登録できないこと' do
      balance = build(:balance, height: '')
      balance.valid?
      expect(balance.errors[:height]).to include('を入力してください')
    end

    it 'weightが空では登録できないこと' do
      balance = build(:balance, weight: '')
      balance.valid?
      expect(balance.errors[:weight]).to include('を入力してください')
    end

    it 'ageが空では登録できないこと' do
      balance = build(:balance, age: '')
      balance.valid?
      expect(balance.errors[:age]).to include('を入力してください')
    end

    it 'fitness_typeが未選択では登録できないこと' do
      balance = build(:balance, fitness_type: 0)
      balance.valid?
      expect(balance.errors[:fitness_type]).to include('は一覧にありません')
    end

    it 'activityが未選択では登録できないこと' do
      balance = build(:balance, activity: 0)
      balance.valid?
      expect(balance.errors[:activity]).to include('は一覧にありません')
    end

    it 'weightが数字以外の場合は登録できないこと' do
      balance = build(:balance, weight: 'aaa')
      balance.valid?
      expect(balance.errors[:weight]).to include('は数値で入力してください')
    end

    it 'heightが数字以外の場合は登録できないこと' do
      balance = build(:balance, height: 'aaa')
      balance.valid?
      expect(balance.errors[:height]).to include('は数値で入力してください')
    end

    it 'ageが数字以外の場合は登録できないこと' do
      balance = build(:balance, age: 'aaa')
      balance.valid?
      expect(balance.errors[:age]).to include('は数値で入力してください')
    end

    it 'heightが半角数字以外の文字では登録できないこと' do
      balance = build(:balance, height: '３００')
      balance.valid?
      expect(balance).to be_invalid
    end

    it 'heightが250を超えたら登録できないこと' do
      balance = build(:balance, height: '251')
      balance.valid?
      expect(balance).to be_invalid
    end

    it 'weightが半角数字以外の文字では登録できないこと' do
      balance = build(:balance, weight: '３００')
      balance.valid?
      expect(balance).to be_invalid
    end

    it 'weightが200を超えたら登録できないこと' do
      balance = build(:balance, weight: '201')
      balance.valid?
      expect(balance).to be_invalid
    end

    it 'ageが半角数字以外の文字では登録できないこと' do
      balance = build(:balance, age: '３００')
      balance.valid?
      expect(balance).to be_invalid
    end

    it 'ageが150を超えたら登録できないこと' do
      balance = build(:balance, age: '151')
      balance.valid?
      expect(balance).to be_invalid
    end
  end
end
