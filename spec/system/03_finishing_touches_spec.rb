# frozen_string_literal: true

require 'rails_helper'

describe '[STEP3] 詳細のテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post_event) { create(:post_event, user: user) }
  let!(:other_post_event) { create(:post_event, user: other_user) }

  describe 'ログインしていない場合のアクセス制限のテスト: アクセスできず、ログイン画面に遷移する' do
    subject { current_path }

    it 'イベント詳細画面', spec_category: "画面表示や機能制限のロジック設定" do
      visit post_event_path(post_event)
      is_expected.to eq '/users/sign_in'
    end
    it 'ユーザ情報編集画面', spec_category: "画面表示や機能制限のロジック設定" do
      visit edit_user_path(user)
      is_expected.to eq '/users/sign_in'
    end
    it '投稿編集画面', spec_category: "画面表示や機能制限のロジック設定" do
      visit edit_post_event_path(post_event)
      is_expected.to eq '/users/sign_in'
    end
  end

  describe '他人の画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    describe '他人の投稿詳細画面' do
      before do
        visit post_event_path(other_post_event)
      end

      context '表示内容の確認' do
        it 'URLが正しい', spec_category: "コントローラの処理" do
          expect(current_path).to eq '/post_events/' + other_post_event.id.to_s
        end
        it 'ユーザーの名前のリンク先が正しい', spec_category: "コントローラの処理" do
          expect(page).to have_link other_post_event.user.name, href: user_path(other_post_event.user)
        end
        it '投稿のtitleが表示される', spec_category: "コントローラの処理" do
          expect(page).to have_content other_post_event.title
        end
        it '投稿の編集リンクが表示されない', spec_category: "コントローラの処理" do
          expect(page).not_to have_link '編集'
        end
        it '投稿の削除リンクが表示されない', spec_category: "コントローラの処理" do
          expect(page).not_to have_link '削除'
        end
      end
    end

    describe '他人のユーザ詳細画面' do
      before do
        visit user_path(other_user)
      end

      context '表示の確認' do
        it 'URLが正しい', spec_category: "アソシエーション" do
          expect(current_path).to eq '/users/' + other_user.id.to_s
        end
        it '他人の名前と紹介文が表示される', spec_category: "アソシエーション" do
          expect(page).to have_content other_user.name
          expect(page).to have_content other_user.introduction
        end
        it '投稿一覧に他人の投稿のtitleが表示され、リンクが正しい', spec_category: "アソシエーション" do
          expect(page).to have_link other_post_event.title, href: post_event_path(other_post_event)
        end
        it '自分のユーザ編集画面へのリンクは存在しない', spec_category: "アソシエーション" do
          expect(page).not_to have_link '', href: edit_user_path(user)
        end
      end
    end

    context '他人のユーザ情報編集画面' do
      it '遷移できず、自分のユーザ詳細画面にリダイレクトされる', spec_category: "画面表示や機能制限のロジック設定" do
        visit edit_user_path(other_user)
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end
