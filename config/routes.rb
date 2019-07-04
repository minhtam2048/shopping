Rails.application.routes.draw do
  resources :line_items
  resources :carts
  # get 'order_items/create'
  # get 'order_items/update'
  # get 'order_items/destroy'
  devise_for :users
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/about'
 
   
 as :user do
  get "signin" => "devise/sessions#new"
  post "signin" => "devise/sessions#create"
  delete "signout" => "devise/sessions#destroy"
 end
 

 resources :items do 
  resources :reviews
 end


 
 
 
  
 resources :conversations do
   resources :messages
 end

 resources :ur_stores

 resources :categories

 resources :users
end
