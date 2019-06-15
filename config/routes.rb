Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/about'
 
   
 as :user do
  get "signin" => "devise/sessions#new"
  post "signin" => "devise/sessions#create"
  delete "signout" => "devise/sessions#destroy"
 end

 resources :items
end
