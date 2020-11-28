# frozen_string_literal: true

require 'rails_helper'

describe BalancesController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'ログイン時' do
      before do
        login user
      end

      context 'セーブが成功した場合' do
        it 'PFCバランスが登録されること' do
          balance = { balance: FactoryBot.attributes_for(:balance).merge(user_id: user.id) }
          expect {
            post :create, params: balance
          }.to change(Balance, :count).by(1)
        end

        it 'マイページにリダイレクトすること' do
          balance = { balance: FactoryBot.attributes_for(:balance).merge(user_id: user.id) }
          post :create, params: balance
          expect(response).to redirect_to(user_path(user))
        end
      end

      context 'セーブが失敗した場合' do
        it 'PFCバランスが登録されないこと' do
          balance = { balance: FactoryBot.attributes_for(:balance, gender: '').merge(user_id: user.id) }
          expect {
            post :create, params: balance
          }.not_to change(Balance, :count)
        end

        it 'リダイレクト先に遷移するかどうか' do
          balance = { balance: FactoryBot.attributes_for(:balance, name: '').merge(user_id: user.id) }
          post :create, params: balance
          expect(response).to redirect_to(user_path(user))
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログイン時' do
      before do
        login user
      end

      context '更新に成功した場合' do
        it 'PFCバランスが更新されること' do
          balance = create(:balance)
          expect {
            patch :update, params: {
              id: balance.id, balance: attributes_for(:balance)
            }
          }.to change(Balance, :count).by(0)
        end

        it 'トップページにリダイレクトすること' do
          balance = create(:balance)
          patch :update, params: {
            id: balance.id, balance: attributes_for(:balance)
          }
          expect(response).to redirect_to(user_path(user))
        end
      end

      context '更新に失敗した場合' do
        it 'PFCバランスが更新されないこと' do
          balance = create(:balance)
          expect {
            patch :update, params: {
              id: balance.id, balance: attributes_for(:balance, gender: '')
            }
          }.not_to change(Balance, :count)
        end

        it 'マイページにリダイレクトするかどうか' do
          balance = create(:balance)
          patch :update, params: {
            id: balance.id, balance: attributes_for(:balance, gender: '')
          }
          expect(response).to redirect_to(user_path(user))
        end
      end
    end
  end
end
