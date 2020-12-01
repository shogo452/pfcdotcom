# frozen_string_literal: true

require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    context 'ログイン時' do
      before do
        login user
      end

      it 'showアクションのページに遷移するか' do
        get :show, params: { id: user }
        expect(response).to render_template :show
      end

      it '@userは正しくアサインされるか' do
        get :show, params: { id: user }
        expect(assigns(:user)).to eq user
      end

      it '正常なレスポンスか' do
        get :show, params: { id: user }
        expect(response).to be_successful
      end

      it '200レスポンスが返ってきているか' do
        get :show, params: { id: user }
        expect(response).to have_http_status '200'
      end
    end

    it '未ログイン時にユーザー登録ページに遷移するか' do
      get :show, params: { id: user }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
