Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to=> "movie#index"

  resources :movie do
    collection do
      get :search
      get :rakeTask
    end
  end





end
