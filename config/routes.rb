Rails.application.routes.draw do

  resources :home, only: [:index]

  resources :users

  resources :projects, except: [:index]

  resources :my_projects, only: [:index]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root "home#index"

end
