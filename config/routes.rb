Rails.application.routes.draw do
  devise_for :users
  resources :events do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: %i[show edit update]

  root to: 'events#index'
end
