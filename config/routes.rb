Rails.application.routes.draw do
  resources :users, only: [:new,:create,:show]
  root "welcome#index"
  resources :organizations, only: [:index, :show] do
    resources :donations, only: [:new, :create]
    resources :reviews, only: [:create]
  end
  
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
end
