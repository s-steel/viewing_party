Rails.application.routes.draw do

  root 'welcome#index'

  post '/', to: 'sessions#create', as: :login

  get '/dashboard', to: 'users#show'
end
