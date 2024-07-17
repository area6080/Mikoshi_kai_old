# frozen_string_literal: true

puts "seedよりデータ作成開始"

Admin.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |admin|
  admin.password = ENV["ADMIN_PASSWORD"]
end


onihei = User.find_or_create_by!(email: "aaa@aaa") do |user|
  user.name = "長谷川　平蔵"
  user.introduction = "＠鬼平でSNSに登録しています。follow me!"
  user.password = "aaaaaa"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/onihei.jpg"), filename: "onihei.jpg")
end

fishman = User.find_or_create_by!(email: "zzz@zzz") do |user|
  user.name = "鮪　一番星"
  user.introduction = "豊洲で海鮮料理店を経営しています。"
  user.password = "zzzzzz"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/fish_man.jpg"), filename: "fish_man.jpg")
end

galileo = User.find_or_create_by!(email: "sss@sss") do |user|
  user.name = "ガリレオ"
  user.introduction = "日本の文化が好きで移住しました。もう500年ほど前です。"
  user.password = "ssssss"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/galileo.jpg"), filename: "galileo.jpg")
end


PostEvent.find_or_create_by!(title: "海上神輿祭") do |post_event|
  post_event.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/torii.jpg"), filename: "torii.jpg")
  post_event.user = onihei
  post_event.caption = "左足が沈む前に右足を出しましょう！"
  post_event.event_date = "2024/08/01"
  post_event.address = "広島県廿日市市宮島町"
end

PostEvent.find_or_create_by!(title: "超神田フェステイバル") do |post_event|
  post_event.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kanda.jpg"), filename: "kanda.jpg")
  post_event.user = fishman
  post_event.caption = "長年続いている伝統行事が今年も開催されます。"
  post_event.event_date = "2024/08/01"
  post_event.address = "東京都千代田区外神田２丁目"
end

PostEvent.find_or_create_by!(title: "なんとかだんじり祭り") do |post_event|
  post_event.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/danjiri.jpg"), filename: "danjiri.jpg")
  post_event.user = galileo
  post_event.caption = "最高時速は300kmを超えるところが見どころ！四兄弟ならではのチームワークにより圧倒的なスピードを実現しています。"
  post_event.event_date = "2024/09/01"
  post_event.address = "大阪府岸和田市岸城町"
end

PostEvent.find_or_create_by!(title: "琵琶湖恐竜まつり") do |post_event|
  post_event.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/dino.jpg"), filename: "danjiri.jpg")
  post_event.user = galileo
  post_event.caption = "原寸大の恐竜が琵琶湖に出現"
  post_event.event_date = "2024/11/11"
  post_event.address = "滋賀県彦根市大藪町"
end

puts "seedの実行完了"
