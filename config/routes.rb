Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Blazer::Engine, at: 'blazer'

  # User lookup
  get 'user_lookup' => 'user_lookup#new'
  post 'user_lookup' => 'user_lookup#create'
  #get 'email_fingerprint' => 'email_fingerprint#index'
  #post 'email_fingerprint' => 'email_fingerprint#create'

  # Manage admins
  get '/admins/new' => 'admins#new', as: :new_admin
  post '/admins' => 'admins#create'
  get '/admins' => 'admins#index'
  delete '/admins/:id' => 'admins#destroy', as: :admin

  # Sign in
  get '/auth/logindotgov/callback', to: 'auth#new'
  delete '/auth/sign_out', to: 'auth#destroy'

  # Homepage
  root to: 'home#index'
end
