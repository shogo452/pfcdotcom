require 'rails_helper'

describe RecordsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'ログイン時' do
      before do
        login user
      end

      context 'セーブが成功した場合' do
        it '記録が登録されること' do
          record = {record: FactoryBot.attributes_for(:record).merge(user_id: user.id)}
          expect {
            post :create, params: record
          }.to change(Record, :count).by(1)
        end

        it 'マイページにリダイレクトすること' do
          record = {record: FactoryBot.attributes_for(:record).merge(user_id: user.id)}
          post :create, params: record
          expect(response).to redirect_to(user_path(user))
        end
      end

      context 'セーブが失敗した場合' do
        it '記録が登録されないこと' do
          record = {record: FactoryBot.attributes_for(:record, weight: "").merge(user_id: user.id)}
          expect { 
            post :create, params: record
          }.not_to change(Record, :count)
        end

        it 'マイページにリダイレクトすること' do
          record = {record: FactoryBot.attributes_for(:record, weight: "").merge(user_id: user.id)}
          post :create, params: record
          expect(response).to redirect_to(user_path(user))
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログイン時' do
      before do
        login user
      end
      it "記録が削除されること" do
        record = create(:record, user_id: user.id)
        expect {
          delete :destroy, 
          params: {id: record.id}
        }.to change(Record, :count).by(-1)
      end

      it "マイページにリダイレクトすること" do
        record = create(:record, user_id: user.id)
        delete :destroy, params: {id: record.id}
        expect(response).to redirect_to(user_path(user))
      end
    end
  end
end

