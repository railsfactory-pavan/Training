Rails.application.routes.draw do
  resources :orders
  resources :addresses
  resources :users
  resources :products
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
