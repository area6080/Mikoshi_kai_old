# frozen_string_literal: true

FactoryBot.define do
  factory :post_event do
    title { Faker::Lorem.characters(number: 6) }
    event_date { Faker::Lorem.characters(number: 8) }
    address { Faker::Lorem.characters(number: 20) }
    user
  end
end
