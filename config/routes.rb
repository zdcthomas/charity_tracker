Rails.application.routes.draw do
  resources :users, only: [:new,:create]
  root "welcome#index"
  resources :organizations, only: [:index]
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
end
