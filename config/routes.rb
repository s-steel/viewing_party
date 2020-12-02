Rails.application.routes.draw do

  root 'welcome#index'

  post '/', to: 'sessions#create'

  get '/dashboard', to: 'users#show'
end
