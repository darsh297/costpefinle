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
   resources :clients do
    member do
      delete :soft_delete
    end
  end

  resources :workreports do
    collection do
      get 'others'
    end
  end

  post '/create', to: 'users#create'
  resources :users, only: [:index, :new, :create, :edit , :show]
end
