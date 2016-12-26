Rails.application.routes.draw do
  post 'auth_admin' => 'admin_authentication#authenticate_admin'
  resources :admins, controller: :admin do
    collection do
      post 'create_driver'
      post 'create_dispatcher'
      post 'create_client'
      get 'show_driver'
      get 'show_dispatcher'
      get 'show_client'
      put 'update_driver'
      put 'update_dispatcher'
      put 'update_client'
      post 'destroy_driver'
      post 'destroy_dispatcher'
      post 'destroy_client'
      get 'index_driver'
      get 'index_dispatcher'
      get 'index_client'
    end
  end
  resources :orders, only: [:index, :create, :update, :show] do
    member do
      patch 'cancel'
      patch 'apply'
      patch 'complete'
    end
  end
  resources :dispatchers, only: [:index, :create]
  resources :drivers, only: [:index, :create]
end
