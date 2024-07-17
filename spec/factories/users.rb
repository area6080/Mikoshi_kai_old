# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    sequence(:email) { Faker::Internet.email }
    password { "password-" }
    password_confirmation { "password-" }
  end
end
