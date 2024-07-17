# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  describe "モデルのテスト" do
    it "有効なユーザーは保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe "バリデーションのテスト" do
    subject { user.valid? }

    let(:user) { build(:user) }

    context "nameカラム" do
      it "空欄でない", spec_category: "バリデーション" do
        user.name = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "PostEventモデルとの関係" do
      it "1:Nとなっている", spec_category: "アソシエーション" do
        expect(User.reflect_on_association(:post_events).macro).to eq :has_many
      end
    end
    context "PostCommentモデルとの関係" do
      it "1:Nとなっている", spec_category: "アソシエーション" do
        expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
  end
end
