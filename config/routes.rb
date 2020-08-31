Rails.application.routes.draw do
  resources :events
  resources :users, only: %i[show edit update]

  root 'events#index'

  devise_for :users
end
