Rails.application.routes.draw do
  post 'auth_admin' => 'admin_authentication#authenticate_admin'
  post 'create_admin' => 'admin#create_admin'
  post 'create_driver' => 'admin#create_driver'
  post 'create_dispatcher' => 'admin#create_dispatcher'
  get 'admin' => 'admin#index'
  resources :orders, only: [:index, :create, :update] do
    put 'cancel/:id', on: :collection, to: 'orders#cancel'
  end
  resources :dispatchers, only: [:index, :create]
  resources :drivers, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
