Rails.application.routes.draw do

  root 'welcome#index'

  get '/dashboard', to: 'sessions#new', as: :login
  post '/dashboard', to: 'sessions#create'
end
