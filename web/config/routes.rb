WebApp.router.config do
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout'
  post '/users', to: 'users#create'
  post '/lists', to: 'lists#create'
  post '/invitations', to: 'invitations#create'
end