Rails.application.routes.draw do
  
  root 'static_pages#home'
  get "users/new" => "users#new"
  get "home" => "static_pages#home"
  resources :users
  resource :session
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
