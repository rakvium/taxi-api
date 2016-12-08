Rails.application.routes.draw do
  devise_for :drivers #, defaults: { format: :json } # из-за undefined method `flash'
  post 'auth_user' => 'authentication#authenticate_user'
  get 'home' => 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
