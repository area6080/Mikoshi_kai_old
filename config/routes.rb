Rails.application.routes.draw do

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :admin do
    get 'homes/top' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :destroy]
    resources :post_events, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :show, :destroy]
  end

  scope module: :public do
    root 'homes#top'
    resources :users, only: [:edit, :update, :destroy]
    get 'users/mypage' => 'customers#show', as: 'mypage'
    resources :groups, except: [:index]
    resources :participations, only: [:create, :destroy]
    resources :post_events, except: [:index] do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :favorites, only: [:create, :destroy]
  end
  
  get 'searches/index' => 'search#index', as: 'search'
  get 'maps/show' => 'map#show', as: 'map'
end
