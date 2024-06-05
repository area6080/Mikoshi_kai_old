Rails.application.routes.draw do

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :admin do
    get '/' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :destroy]
    resources :post_events, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :show, :destroy]
  end

  scope module: :public do
    root 'homes#top'
    resources :users, only: [:edit, :update, :destroy]
    get 'mypage' => 'customers#show', as: 'mypage'
    resources :groups, except: [:index] do
      resource :participation, only: [:create, :destroy]
    end
    resources :post_events, except: [:index] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end
  end

  get 'searches/index' => 'searches#index', as: 'search'
  get 'map' => 'maps#show', as: 'map'
end
