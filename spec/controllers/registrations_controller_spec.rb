require 'rails_helper'

describe Users::RegistrationsController do
  let(:user) { create(:user) }

  context 'log in' do
    before do
      login user
    end

    describe 'GET #new' do
      it "トップページにリダイレクトされるか" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  context 'log out' do
    describe 'GET #new' do
      it "ユーザー登録ページに遷移するか" do
        request.env["devise.mapping"] = Devise.mappings[:user]
        get :new
        expect(response).to render_template :new
      end
    end
  end
end
