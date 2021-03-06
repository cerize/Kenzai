Rails.application.routes.draw do

  resources :home, only: [:index]

  resources :users, only: [:new, :create, :show]

  post '/project_member/manager' => 'project_assignments#add_manager', as: :add_manager

  post '/project_member/not_manager' => 'project_assignments#remove_manager', as: :remove_manager

  get '/project_member/search' => 'project_assignments#search_member', as: :search_member

  get '/project/map' => 'projects#map', as: :project_map

  resources :projects, except: [:index] do
    resources :sprints
    resources :snippets
    resources :mudas
  end

  post '/project/complete' => 'projects#complete', as: :project_complete
  post '/project/cancel' => 'projects#cancel', as: :project_cancel

  post '/tasks/complete' => 'tasks#complete', as: :task_complete

  resources :sprints, only: [] do
    resources :user_stories, except: [:index, :show]
    resources :tasks, except: [:show]
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :planning_highlights, only: [:index, :new, :create, :destroy]
    resources :review_highlights, only: [:index, :new, :create, :destroy]
  end

    # get '/sprints/:sprint_id/tasks/tree' => 'tasks#tree_data', as: :task_tree

  resources :project_assignments, only: [:new, :create, :destroy]
  resources :task_assignments, only: [:create, :destroy]

  resources :my_projects, only: [:index]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]


  root "home#index"

end
