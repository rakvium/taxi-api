Rails.application.routes.draw do
  post 'auth_user' => 'authentication#authenticate_user'
  devise_for :drivers #, defaults: { format: :json } # из-за undefined method `flash'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
