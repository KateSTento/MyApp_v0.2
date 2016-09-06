Rails.application.routes.draw do
  
  get "users/new" => "users#new"

  root 'static_pages#home'
  
  get "home" => "static_pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
