Rails.application.routes.draw do
  devise_for :admins, path: "admin"

  root "pages#main"
  
  get "/main", to: "pages#main"
  resources :search, only: :index
  resources :names, only: %i[index show]
  resources :selections, only: :index
  resources :posts, only: %i[index show]
  resources :name_days, only: :index do
    # TODO: remove parenthesis after adding Admin feature
    get "(/month/:month)", action: :index, on: :collection, as: "", defaults: { month: NameDay::DEFAULT_MONTH }
  end

  get "admin", to: "admin/names#index"
  namespace :admin do
    resources :origin_countries, only: %i[new create]
    resources :names, except: :show
    resources :selections, except: :show
    resources :posts, except: :show
    resources :name_days, except: :show do
      get "(/month/:month)", action: :index, on: :collection, as: "", defaults: { month: NameDay::DEFAULT_MONTH }
    end
  end
end
