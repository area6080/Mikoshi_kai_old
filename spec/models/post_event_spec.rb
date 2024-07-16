# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostEventモデルのテスト', type: :model do
  
  describe 'モデルのテスト' do
    it "有効な投稿は保存されるか" do
      expect(FactoryBot.build(:post_event)).to be_valid
    end
  end  
  
  describe 'バリデーションのテスト' do
    subject { post_event.valid? }

    let(:user) { create(:user) }
    let!(:post_event) { build(:post_event, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと', spec_category: "バリデーション" do
        post_event.title = ''
        is_expected.to eq false
      end
    end

    context 'event_dateカラム' do
      it '空欄でないこと', spec_category: "バリデーション" do
        post_event.event_date = ''
        is_expected.to eq false
      end
    end
    
    context 'addressカラム' do
      it '空欄でないこと', spec_category: "バリデーション" do
        post_event.address = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている', spec_category: "アソシエーション" do
        expect(PostEvent.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
