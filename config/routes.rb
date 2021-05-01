Rails.application.routes.draw do
  root to: "tasks#index"

  resources :tasks
  resource :users, controller: 'registrations', only: [:create] do
    get '/sign_up', action: 'new'
  end
end
