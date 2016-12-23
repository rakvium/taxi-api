Rails.application.routes.draw do
  post 'auth_admin' => 'admin_authentication#authenticate_admin'
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
      get 'index_admin'
      get 'index_driver'
      get 'index_dispatcher'
      get 'index_client'
    end
  end
  resources :orders, only: [:index, :create, :update, :show] do
    member do
      put 'cancel'
    end
  end
  resources :dispatchers, only: [:index, :create]
  resources :drivers, only: [:index, :create]
end
