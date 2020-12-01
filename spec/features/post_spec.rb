# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Posts', type: :feature do
  before do
    User.create!(
      nickname: 'test',
      email: 'test@example.com',
      password: 'abc12345',
      password_confirmation: 'abc12345'
    )
  end

  it '新規投稿' do
    visit root_path

    click_link 'ログイン'

    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'abc12345'

    click_button 'ログイン'

    expect {
      click_link '新規投稿'
      fill_in 'product[name]', with: 'テスト'
      fill_in 'product[protein]', with: '12.3'
      fill_in 'product[fat]', with: '23.4'
      fill_in 'product[carbo]', with: '43.5'
      click_button '投稿する'
    }.to change(Product, :count).by(1)
  end
end
