Rails.application.routes.draw do
  root 'static_pages#home'
  get '/home', to: 'static_pages#home', as: 'home'
  post '/login_invitations', to: 'login_invitations#create'
  get '/login_invitations/verify/:hash', to: 'login_invitations#verify', as: 'login_invitations_verify'
  post '/login', to: 'sessions#create', as: 'login'
  resources :messages, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
