# frozen_string_literal: true

require 'rails_helper'
describe 'post', type: :feature do
  before do
    User.create!(
      nickname: 'test',
      email: 'test@example.com',
      password: 'abc12345',
      password_confirmation: 'abc12345'
    )
  end

  it 'ログインと新規投稿' do
    visit root_path
    expect(page).to have_no_content('新規投稿')

    click_link 'ログイン'

    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'abc12345'

    click_button 'ログイン'

    expect(page).to have_current_path root_path, ignore_query: true
    expect(page).to have_content('新規投稿')

    image_path = File.join(Rails.root, 'spec/features/test_image.jpg')
    expect {
      click_link '新規投稿'
      fill_in 'product[name]', with: 'テスト'
      fill_in 'product[protein]', with: '12.3'
      fill_in 'product[fat]', with: '23.4'
      fill_in 'product[carbo]', with: '43.5'
      fill_in 'product[sugar]', with: '12.3'
      fill_in 'product[calory]', with: '234'
      fill_in 'product[price]', with: '345'
      fill_in 'product[purchase_url]', with: 'https://example.com'
      fill_in 'product[tag_list]', with: 'abc, def, ghi, jkl, mno'
      find('#file', visible: false).set(image_path)
      click_button '投稿する'
    }.to change(Product, :count).by(1)
    expect(page).to have_current_path root_path, ignore_query: true
    expect(page).to have_content('テスト')
  end

  it '編集' do
    visit root_path

    click_link 'ログイン'

    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'abc12345'

    click_button 'ログイン'

    click_link '新規投稿'
    fill_in 'product[name]', with: '編集テスト'
    fill_in 'product[protein]', with: '12.3'
    fill_in 'product[fat]', with: '23.4'
    fill_in 'product[carbo]', with: '43.5'
    click_button '投稿する'
    expect(page).to have_current_path root_path, ignore_query: true
    link = find('#product-name', text: '編集テスト')
    link.click
    find('#edit-btn').click
    expect(page).to have_button('編集内容を保存する')
    expect {
      fill_in 'product[name]', with: '編集テスト2'
      click_button '編集内容を保存する'
    }.to change(Product, :count).by(0)
    expect(page).to have_current_path root_path, ignore_query: true
    expect(page).to have_content('編集テスト2')
  end
end
