Rails.application.routes.draw do
  devise_for :drivers # defaults: { format: :json } # undefined method `flash'
  post 'auth_driver' => 'authentication#authenticate_driver'
  post 'auth_admin' => 'admin_authentication#authenticate_admin'
  post 'create_admin' => 'admin#create_admin'
  post 'create_driver' => 'admin#create_driver'
  post 'create_dispatcher' => 'admin#create_dispatcher'
  get 'home' => 'home#index'
  get 'admin' => 'admin#index'
  resources :orders, only: [:index, :create, :update]
  resources :admins, only: [:index, :create_admin, :create_dispatcher, :create_driver]
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
