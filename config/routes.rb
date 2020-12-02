Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  resource :registration, only: [:new], controller: 'users'
  resource :dashboard, only: [:show], controller: 'users'
end
