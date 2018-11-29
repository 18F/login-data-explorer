Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Blazer::Engine, at: 'blazer'
  get 'email_fingerprint' => 'email_fingerprint#index'
  post 'email_fingerprint' => 'email_fingerprint#create'
  get '/auth/logindotgov/callback', to: 'auth#callback'
end
