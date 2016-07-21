Rails.application.routes.draw do

  resources :movies do 
    resources :reviews, only: [:new, :create]
  end

  namespace :admin do
    resources :users
    resource :shadow_sessions, only: [:new, :create, :destroy]
  end

  resources :users, only: [:new, :create, :show]
  
  resource :session, only: [:new, :create, :destroy]


  root to: 'movies#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
