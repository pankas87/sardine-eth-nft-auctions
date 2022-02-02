Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  post '/register', to: 'users#create'
  post '/bids', to: 'bids#create'
  get '/view', to: 'views#index'
end
