require 'sidekiq/web'

Rails.application.routes.draw do
  resources :profiles
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :messages
  resources :matches
  resources :swipes
  resources :usertables
  resources :memberships
  resources :profiles

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end


  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "usertables#index"
end