Rails.application.routes.draw do
  resources :scenes do
    get 'renderer', on: :new
  end
  resources :users
  resources :nodes, only: [:show, :index], constraints: { id: /[^\/]+/ }, format: false
  root to: 'visitors#index'
  match '/auth/:provider/callback', to: "sessions#create", via: [:get, :post]
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
