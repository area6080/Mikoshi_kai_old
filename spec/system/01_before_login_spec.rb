# frozen_string_literal: true

require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい', spec_category: "ルーティング" do
        expect(current_path).to eq '/'
      end

      it 'ログインリンクの内容が正しい', spec_category: "ルーティング" do
        expect(page).to have_link 'ログイン', href: new_user_session_path
      end

      it '新規登録リンクの内容が正しい', spec_category: "ルーティング" do
        expect(page).to have_link '新規登録', href: new_user_registration_path
      end
      
      it '管理者用リンクの内容が正しい', spec_category: "ルーティング" do
        expect(page).to have_link '管理者用', href: new_admin_session_path
      end
    end
  end


  describe 'ユーザ新規登録' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい', spec_category: "deviseの導入" do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規登録」と表示される', spec_category: "deviseの導入" do
        expect(page).to have_content '新規登録'
      end
      it 'nameフォームが表示される', spec_category: "deviseの導入" do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される', spec_category: "deviseの導入" do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される', spec_category: "deviseの導入" do
        expect(page).to have_field 'user[password]'
      end
      it 'Sign upボタンが表示される', spec_category: "deviseの導入" do
        expect(page).to have_button 'Sign up'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password-'
      end

      it '正しく新規登録される', spec_category: "コントローラの処理" do
        expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面', spec_category: "コントローラの処理" do
        click_button 'Sign up'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい', spec_category: "deviseの導入" do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される', spec_category: "deviseの導入" do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される', spec_category: "deviseの導入" do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される', spec_category: "deviseの導入" do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される', spec_category: "deviseの導入" do
        expect(page).to have_button 'Log in'
      end
      it 'nameフォームは表示されない', spec_category: "deviseの導入" do
        expect(page).not_to have_field 'user[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面', spec_category: "コントローラの処理" do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end

  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    context 'ヘッダーの表示を確認' do
      
      it 'My Pageボタンが表示される', spec_category: "ログイン状況による画面表示" do
        expect(page).to have_link 'My Page'
      end
      
      it 'MAPボタンが表示される', spec_category: "ログイン状況による画面表示" do
        expect(page).to have_link 'MAP'
      end
      
      it 'ログアウトボタンが表示される', spec_category: "ログイン状況による画面表示" do
        expect(page).to have_link 'ログアウト'
      end
      
    end
  end

  describe 'ユーザログアウト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      
      click_link 'ログアウト'
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている', spec_category: "コントローラの処理" do
        expect(current_path).to eq '/'
      end
    end
  end
end
