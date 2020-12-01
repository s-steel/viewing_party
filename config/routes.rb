Rails.application.routes.draw do

  root 'welcome#index'

  get '/', to: 'sessions#new', as: :login
  post '/', to: 'sessions#create'

  get '/dashboard', to: 'users#show'
end
