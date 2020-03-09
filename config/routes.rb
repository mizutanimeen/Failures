Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  get "ranking", to: "toppages#ranking"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to:  "users#new"
  delete "withdraw", to: "users#destroy"
  
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      get :post
      get :reply
    end
  end
  
  resources :questions do
    resources :answers, only: [:create]
    get :search, on: :collection
  end
  
  get :tags, to: "tags#tag"
  resources :tags, only: [] do
    collection do
      get :other
      get :work
      get :home
    end
  end
  
  get :search, to: "questions#search"
  get :result, to: "questions#result"

  resources :answers, only: [:destroy]
  
  resources :favorites, only: [:create, :destroy]
  
  resources :microposts 
  get :news, to: "microposts#new"
end
