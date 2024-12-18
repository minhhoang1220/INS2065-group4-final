require 'sidekiq/web'

Rails.application.routes.draw do
  resources :profiles
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :messages
  resources :matches
  resources :swipes
  resources :usertables
  resources :memberships

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :swipes do
    collection do
      post :like_or_dislike
    end
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "usertables#index"

  resources :matches do
    resources :messages, only: [:index, :create]
  end
end