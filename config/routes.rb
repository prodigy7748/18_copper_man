Rails.application.routes.draw do
  root to: "tasks#index"

  resources :tasks
  get "/search" => "tasks#search", :as => "search_page"
end
