Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#delete'
  
  root "posts#index"
  get 'site/home'
  # get '/posts', to:'posts#show'
  # get "/posts/:id", to: "posts#post"

  resources :users
  resources :posts do
    resources :comments
  end
end
