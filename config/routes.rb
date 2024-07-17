# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin, skip: %i[registrations passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users, skip: %i[passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
  }

  devise_scope :user do
    post "guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  namespace :admin do
    get "/" => "homes#top", as: "top"
    resources :users, only: %i[index show destroy]
    resources :post_events, only: %i[index show destroy]
    resources :post_comments, only: %i[index show destroy]
    resources :groups, only: %i[index show destroy]
  end

  scope module: :public do
    root "homes#top"
    resources :users, only: %i[show edit update destroy]
    resources :groups do
      resource :participation, only: %i[create destroy]
    end
    resources :post_events do
      resources :post_comments, only: %i[create destroy]
      resource :favorite, only: %i[create destroy]
      resource :union, only: %i[show create destroy]
    end
  end

  get "searches/index" => "searches#index", as: "search"
  get "map" => "maps#show", as: "map"
end
