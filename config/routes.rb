Rails.application.routes.draw do

  resources :users do
    resources :projects
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root "home#index"

end
