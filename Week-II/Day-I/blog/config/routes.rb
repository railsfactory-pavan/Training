Rails.application.routes.draw do

  get 'welcome/index'
  resources :articles do
    resources :comments
  end

  root 'welcome#index'

  # these routes are for showing users a login form, logging them in, and logging them out.
   get '/login' => 'sessions#new'
   post '/login' => 'sessions#create'
   get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
   post '/users' => 'users#create'
   get 'allusers' => 'users#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
