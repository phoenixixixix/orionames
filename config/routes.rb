Rails.application.routes.draw do
  root "pages#main"

  get "/main", to: "pages#main"
end
