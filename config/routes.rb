Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  get "posts/index" => "posts#index"
  get "posts/:id/edit" => "posts#edit"
  post "posts/create" => "posts#create"
end
