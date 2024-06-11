Admin.create!(
  email: "admin@admin",
  password: "password"
)

# PostEvent.find_or_create_by!(title: "Cavello") do |post_event|
#   post_event.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
#   post_event.caption = "大人気のカフェです。"
#   post_event.address = "大阪府大阪市北区梅田１丁目" 
#   post_event.user.name = 'olivia'
# end

# PostEvent.find_or_create_by!(title: "じゆうきままに") do |post_event|
#   post_event.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
#   post_event.caption = "小泉花陽推しです"
#   post_event.address = "大阪府大阪市中央区心斎橋筋２丁目2-10　新日本三ツ寺ビル" 
#   post_event.user.name = 'tatsuji'
# end

# PostEvent.find_or_create_by!(title: "ShoreditchBar") do |post_event|
#   post_event.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
#   post_event.caption = 'メキシコ料理好きな方にオススメ！'
#   post_event.address = "大阪府大阪市淀川区西中島5-16-1" 
#   post_event.user.name = 'lucas'
# end