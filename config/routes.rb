Rails.application.routes.draw do
  devise_for :drivers
  post 'auth_user' => 'authentication#authenticate_user'
  get 'home' => 'home#index'

  resources :orders, only: [:index, :create]

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
