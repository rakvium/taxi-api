Rails.application.routes.draw do
  # devise_for :dispatchers
  # devise_for :drivers # defaults: { format: :json } # undefined method `flash'
  post 'auth_admin' => 'admin_authentication#authenticate_admin'
  resources :orders, only: [:index, :create, :update, :show]
  resources :dispatchers, only: [:index, :create]
  resources :drivers, only: [:index, :create]
  resources :admins, controller: :admin do
    collection do
      post 'create_driver'
      post 'create_dispatcher'
      get 'show_driver'
      get 'show_dispatcher'
      post 'update_driver'
      post 'update_dispatcher'
      post 'destroy_driver'
      post 'destroy_dispatcher'
    end
  end
  # devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
