Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  resources :profiles
  root "homes#index"

  resources :homes
  resources :workreports
  resources :clients
  resources :projects
  resources :email_hierarchys

  resources :users do
    member do
      delete :soft_delete
    end
  end

  resources :projects do
    member do
      delete :soft_delete
    end
  end

  get '/users/new', to: 'users#add_user'
  post '/create', to: 'users#create'

  # Remove the extra line below
  # post '/create', to: 'projects#create'

    resources :users, only: [:index, :new, :create, :edit , :show]
end
