Rails.application.routes.draw do

  resources :home, only: [:index]

  resources :users

  post '/project_member/manager' => 'project_assignments#add_manager', as: :add_manager

  post '/project_member/not_manager' => 'project_assignments#remove_manager', as: :remove_manager

  get '/project_member/search' => 'project_assignments#search_member', as: :search_member

  resources :projects, except: [:index] do
    resources :sprints
    resources :snippets
    resources :mudas
  end

  post '/project/complete' => 'projects#complete', as: :project_complete
  post '/project/cancel' => 'projects#cancel', as: :project_cancel

  resources :sprints, only: [] do
    resources :user_stories, except: [:index, :show]
  end

  resources :project_assignments, only: [:new, :create, :destroy]

  resources :my_projects, only: [:index]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  root "home#index"

end
