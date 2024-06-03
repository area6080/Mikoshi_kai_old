Rails.application.routes.draw do
  
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  root 'homes/top'
  get 'homes/about'
end
