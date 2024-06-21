Rails.application.routes.draw do

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  devise_scope :user do
    post "guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  namespace :admin do
    get '/' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :destroy]
    resources :post_events, only: [:index, :show, :destroy]
    resources :post_comments, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :show, :destroy]
  end

  scope module: :public do
    root 'homes#top'
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :groups do
      resource :participation, only: [:create, :destroy]
    end
    resources :post_events do
      resources :post_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
      resource :union, only: [:show, :create, :destroy]
    end
  end

  get 'searches/index' => 'searches#index', as: 'search'
  get 'map' => 'maps#show', as: 'map'
end
