Rails.application.routes.draw do
  root "pages#main"
  
  get "/main", to: "pages#main"
    
  resources :names
  resources :selections, except: :show
  resources :posts
  resources :name_days, except: :show do
    # TODO: remove parenthesis after adding Admin feature
    get "(/month/:month)", action: :index, on: :collection, as: "", defaults: { month: NameDay::DEFAULT_MONTH }
  end
  resources :search, only: :index
end
