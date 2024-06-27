json.data do
  json.items do
    json.array!(@post_events) do |post_event|
      json.id post_event.id
      json.user do
        json.name post_event.user.name
        json.image url_for(post_event.user.profile_image)
      end
      json.image url_for(post_event.image)
      json.title post_event.title
      json.date post_event.event_date
      json.caption post_event.caption
      json.address post_event.address
      json.latitude post_event.latitude
      json.longitude post_event.longitude
    end
  end
end
