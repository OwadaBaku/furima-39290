Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  post '/items/new', to: 'items#create'
end
