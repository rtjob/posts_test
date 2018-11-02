Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  get "posts/index" => "posts#index"
  get "posts/:id/edit" => "posts#edit"
  post "posts/create" => "posts#create"

  post "user/create" => "user#userCreate"
  get "user/signup" => "user#userSignUp"
  get "user/userList" => "user#userList"
  get "user/:id" => "user#userDetail"



end
