Rails.application.routes.draw do
  devise_for :users
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  get  'role/purchase' => 'products#purchase'
  get  'role/set_as_admin' => 'products#set_as_admin'
end
