# frozen_string_literal: true

require 'rails_helper'
describe User do
  describe '#create' do
    it '値が全て存在すれば登録できる' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      user = build(:user, nickname: '')
      user.valid?
      expect(user.errors[:nickname]).to include('を入力してください')
    end

    it 'emailが空では登録できないこと' do
      user = build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include('が入力されていません。')
    end

    it 'passwordが空では登録できないこと' do
      user = build(:user, password: '')
      user.valid?
      expect(user.errors[:password]).to include('が入力されていません。')
    end

    it 'passwordとpassword_confirmationが一致していない場合は登録できないこと' do
      user = build(:user, password_confirmation: '')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end
  end
end
