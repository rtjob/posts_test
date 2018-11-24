Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#indexTop'
  get "/indexTop" => "top#indexTop"
  
  # post系
  post "/posts/create" => "posts#create"
  get "/posts/index" => "posts#index"
  post "/posts/index" => "posts#index"
  get "/posts/:id/edit" => "posts#edit"
  post "/posts/:id/update" => "posts#update"
  post "/posts/:id/destroy" => "posts#destroy"
  
  # user系
  post "/user/login" => "user#userLogin"
  post "/user/logout" => "user#userLogout"
  post "/user/create" => "user#userCreate"
  get "/user/signup" => "user#userSignUp"
  get "/user/userList" => "user#userList"
  get "/user/:id" => "user#userDetail"
  post "/user/:id/userEdit" => "user#userEdit"
  post "/user/:id/userUpdate" => "user#userUpdate"
  post "/user/:id/userDestroy" => "user#userDestroy"

end
