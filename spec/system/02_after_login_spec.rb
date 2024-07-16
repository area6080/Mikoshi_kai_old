# frozen_string_literal: true

require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post_event) { create(:post_event, user: user) }
  let!(:other_post_event) { create(:post_event, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト: ログイン時' do
    context 'リンク先' do
      subject { current_path }

      it 'My Pageを押すと、自分のユーザ詳細画面に遷移する', spec_category: "ルーティング" do
        click_link 'My Page'
        is_expected.to eq '/users/' + user.id.to_s
      end
      it 'MAPを押すと、マップ画面に遷移する', spec_category: "ルーティング" do
        click_link 'MAP'
        is_expected.to eq '/map'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit post_events_path
    end

    context '表示内容の確認' do
      it 'URLが正しい', spec_category: "投稿詳細" do
        expect(current_path).to eq '/post_events'
      end
      it '投稿イベントのタイトルのリンク先が正しい', spec_category: "投稿詳細" do
        expect(page).to have_link post_event.title, href: post_event_path(post_event)
      end
      it 'マップ画面へのリンクが存在する', spec_category: "投稿詳細" do
        expect(page).to have_link '', href: map_path
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_event_path(post_event)
    end

    context '表示内容の確認' do
      it 'URLが正しい', spec_category: "投稿詳細" do
        expect(current_path).to eq '/post_events/' + post_event.id.to_s
      end
      it 'ユーザ画像・名前のリンク先が正しい', spec_category: "投稿詳細" do
        expect(page).to have_link post_event.user.name, href: user_path(post_event.user)
      end
      it '投稿のtitleが表示される', spec_category: "投稿詳細" do
        expect(page).to have_content post_event.title
      end
      it '投稿のevent_dateが表示される', spec_category: "投稿詳細" do
        expect(page).to have_content post_event.event_date
      end
      it '投稿のaddressが表示される', spec_category: "投稿詳細" do
        expect(page).to have_content post_event.address
      end
      it '投稿の編集リンクが表示される', spec_category: "投稿詳細" do
        expect(page).to have_link '', href: edit_post_event_path(post_event)
      end
      it '投稿の削除リンクが表示される', spec_category: "投稿詳細" do
        expect(page).to have_link '', href: post_event_path(post_event)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する', spec_category: "投稿詳細" do
        second_post_event = FactoryBot.create(:post_event, user: user)
        visit post_event_path(second_post_event)
        click_link '編集'
        expect(current_path).to eq edit_post_event_path(second_post_event)
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除'
      end
      it '正しく削除される', spec_category: "投稿詳細" do
        expect(PostEvent.where(id: post_event.id).count).to eq 0
      end
      it 'リダイレクト先が、マイページになっている', spec_category: "投稿詳細" do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_post_event_path(post_event)
    end

    context '表示の確認' do
      it 'URLが正しい', spec_category: "投稿詳細" do
        expect(current_path).to eq '/post_events/' + post_event.id.to_s + '/edit'
      end
      it 'title編集フォームが表示される', spec_category: "投稿詳細" do
        expect(page).to have_field 'post_event[title]', with: post_event.title
      end
      it 'event_date編集フォームが表示される', spec_category: "投稿詳細" do
        expect(page).to have_field 'post_event[event_date]', with: post_event.event_date
      end
      it 'address編集フォームが表示される', spec_category: "投稿詳細" do
        expect(page).to have_field 'post_event[address]', with: post_event.address
      end
      it 'Updateボタンが表示される', spec_category: "投稿詳細" do
        expect(page).to have_button 'Update'
      end
    end

    context '編集成功のテスト' do
      before do
        @post_event_old_title = post_event.title
        fill_in 'post_event[title]', with: Faker::Lorem.characters(number: 4)
        click_button 'Update'
      end

      it 'titleが正しく更新される', spec_category: "投稿詳細" do
        expect(post_event.reload.title).not_to eq @post_event_old_title
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている', spec_category: "投稿詳細" do
        expect(current_path).to eq '/post_events/' + post_event.id.to_s
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい', spec_category: "投稿詳細" do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧に自分の投稿のtitleが表示され、リンクが正しい', spec_category: "投稿詳細" do
        expect(page).to have_link post_event.title, href: post_event_path(post_event)
      end
      it '投稿一覧に自分の投稿のevent_dateが表示される', spec_category: "投稿詳細" do
        expect(page).to have_content post_event.event_date
      end
      it '投稿一覧に自分の投稿のaddressが表示される', spec_category: "投稿詳細" do
        expect(page).to have_content post_event.address
      end
      it '自分のユーザ編集画面へのリンクが存在する', spec_category: "投稿詳細" do
        expect(page).to have_link '', href: edit_user_path(user)
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい', spec_category: "投稿詳細" do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される', spec_category: "投稿詳細" do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される', spec_category: "投稿詳細" do
        expect(page).to have_field 'user[profile_image]'
      end
      it 'Update Userボタンが表示される', spec_category: "投稿詳細" do
        expect(page).to have_button 'Update'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        expect(user.profile_image).to be_attached
        click_button 'Update'
        save_page
      end

      it 'nameが正しく更新される', spec_category: "投稿詳細" do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている', spec_category: "投稿詳細" do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end
