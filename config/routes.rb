Rails.application.routes.draw do
  root 'static_pages#home'
  get '/home', to: 'static_pages#home', as: 'home'
  post '/login_invite', to: 'login_invitations#create'
  get '/login_invite/verify/:hash', to: 'login_invitations#verify'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
