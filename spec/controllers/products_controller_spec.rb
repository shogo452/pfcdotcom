# frozen_string_literal: true

require 'rails_helper'

describe ProductsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    context 'ログイン時' do
      before do
        login user
      end

      it 'newアクションのページに遷移するか' do
        get :new
        expect(response).to render_template :new
      end
    end

    it '未ログイン時にログインページへ遷移するか' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST #create' do
    context 'ログイン時' do
      before do
        login user
      end

      context 'セーブが成功した場合' do
        it '商品が登録されること' do
          product = { product: FactoryBot.attributes_for(:product).merge(user_id: user.id) }
          expect {
            post :create, params: product
          }.to change(Product, :count).by(1)
        end

        it 'トップページにリダイレクトすること' do
          product = { product: FactoryBot.attributes_for(:product).merge(user_id: user.id) }
          post :create, params: product
          expect(response).to redirect_to '/'
        end
      end

      context 'セーブが失敗した場合' do
        it '商品が登録されないこと' do
          product = { product: FactoryBot.attributes_for(:product, name: '').merge(user_id: user.id) }
          expect {
            post :create, params: product
          }.not_to change(Product, :count)
        end

        it 'レンダリング先に遷移するかどうか' do
          product = { product: FactoryBot.attributes_for(:product, name: '').merge(user_id: user.id) }
          post :create, params: product
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'GET #show' do
    context 'ログイン時' do
      before do
        login user
      end

      it 'showアクションのページに遷移するか' do
        product = create(:product)
        get :show, params: { id: product }
        expect(response).to render_template :show
      end

      it '@productは正しくアサインされるか' do
        product = create(:product)
        get :show, params: { id: product }
        expect(assigns(:product)).to eq product
      end

      it '正常なレスポンスか' do
        product = create(:product)
        get :show, params: { id: product }
        expect(response).to be_successful
      end

      it '200レスポンスが返ってきているか' do
        product = create(:product)
        get :show, params: { id: product }
        expect(response).to have_http_status '200'
      end
    end

    it '未ログイン時にログインページに遷移するか' do
      product = create(:product)
      get :show, params: { id: product }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET #index' do
    context 'ログイン時' do
      before do
        login user
      end

      it '正常なレスポンスか' do
        get :index
        expect(response).to be_successful
      end

      it '200レスポンスが返ってきているか' do
        get :index
        expect(response).to have_http_status '200'
      end

      it 'indexアクションのページに遷移するか' do
        get :index
        expect(response).to render_template :index
      end
    end

    it '未ログイン時に正常なレスポンスか' do
      get :index
      expect(response).to be_successful
    end

    it '未ログイン時に200レスポンスが返ってきているか' do
      get :index
      expect(response).to have_http_status '200'
    end

    it '未ログイン時にindexアクションのページに遷移するか' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #edit' do
    context 'ログイン時' do
      before do
        login user
      end

      it 'editアクションのページに遷移するか' do
        product = create(:product)
        get :edit, params: { id: product }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログイン時' do
      before do
        login user
      end

      context '更新に成功した場合' do
        it '商品が更新されること' do
          product = create(:product)
          expect {
            patch :update, params: {
              id: product.id, product: attributes_for(:product)
            }
          }.to change(Product, :count).by(0)
        end

        it 'トップページにリダイレクトすること' do
          product = create(:product)
          patch :update, params: {
            id: product.id, product: attributes_for(:product)
          }
          expect(response).to redirect_to root_path
        end
      end

      context '更新に失敗した場合' do
        it '商品が更新されないこと' do
          product = create(:product)
          expect {
            patch :update, params: {
              id: product.id, product: attributes_for(:product, name: '')
            }
          }.not_to change(Product, :count)
        end

        it '編集ページにリダイレクトするかどうか' do
          product = create(:product)
          patch :update, params: {
            id: product.id, product: attributes_for(:product, name: '')
          }
          expect(response).to redirect_to edit_product_path
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログイン時' do
      before do
        login user
      end

      it '商品が削除されること' do
        product = create(:product, user_id: user.id)
        expect {
          delete :destroy,
                 params: { id: product.id }
        }.to change(Product, :count).by(-1)
      end

      it 'トップページにリダイレクトされるかどうか' do
        product = create(:product, user_id: user.id)
        delete :destroy, params: { id: product.id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
