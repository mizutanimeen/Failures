Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "details", to: "questions#details"
  
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
  end
  
  resources :answers, only: [:destroy]
end
