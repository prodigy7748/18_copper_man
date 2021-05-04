Rails.application.routes.draw do
  root to: "tasks#index"

  resources :tasks

  resource :user, controller: 'registrations', only: [:create] do
    get 'sign_up', action: 'new'
  end

  resource :user, controller: 'sessions', only: [] do
    get '/sign_in', action: 'new'
    post '/sign_in', action: 'create'
    delete '/sign_out', action: 'destroy'
  end
end
