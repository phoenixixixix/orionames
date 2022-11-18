Rails.application.routes.draw do
  root "pages#main"
  
  get "/main", to: "pages#main"
    
  resources :names
  resources :name_days, only: :index
end
