Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'user/find_user' => 'user#find_user'
  put 'user/update' => 'user#update'
  resources :user
  post 'room/join' => 'room#join'
  post 'room/ping' => 'room#ping'
  post 'room/exit' => 'room#exit'
  resources :room
end
