Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/auth/google_oauth2/callback' => 'o_auth#callback'
  post '/auth/mobile' => 'mobile_auth#sign_in'
end
