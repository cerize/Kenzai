Rails.application.routes.draw do

  resources :home, only: [:index]

  resources :users

  resources :projects, except: [:index] do
    resources :sprints
  end

  resources :sprints, only: [] do
    resources :user_stories, except: [:index, :show]
  end

  resources :project_assignments, only: [:create, :destroy]

  resources :my_projects, only: [:index]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root "home#index"

end
