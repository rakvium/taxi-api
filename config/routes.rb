Rails.application.routes.draw do
  devise_for :drivers
  post 'auth_user' => 'authentication#authenticate_user'
  get 'home' => 'home#index'

  get 'order' => 'order#index'
  post 'order' => 'order#add_order'

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
