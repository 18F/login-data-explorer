Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Blazer::Engine, at: 'blazer'
  get 'email_fingerprint' => 'email_fingerprint#index'
  post 'email_fingerprint' => 'email_fingerprint#create'
  get '/auth/logindotgov/callback', to: 'auth#new'
  delete '/auth/sign_out', to: 'auth#destroy'
  root to: 'home#index'
end
