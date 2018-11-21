WebApp.router.config do
  get '/home', to: 'home#show'
  post '/login', to: 'users#login'
  post '/users', to: 'users#create'
  post '/lists', to: 'lists#create'
end