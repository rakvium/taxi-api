Rails.application.routes.draw do
  devise_for :drivers # defaults: { format: :json } # из-за undefined method `flash'
  post 'auth_driver' => 'authentication#authenticate_driver'
  post 'auth_admin' => 'admin_authentication#authenticate_admin'
  get 'home' => 'home#index'
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
