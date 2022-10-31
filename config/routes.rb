Rails.application.routes.draw do
  namespace :api do
    resources :posts do
      resources :comments
    end
  end
  # root "posts#index"
  # get '/posts', to:'posts#show'
  # get "/posts/:id", to: "posts#post"


end
