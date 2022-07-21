# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
      # get '/projects/index', to: 'project#index'

      # resources :projects

      resources :projects do
        resources :bugs, only: [:new]
        resources :features, only: [:new]
        resources :code_piece_users, only: [:index] #index is for unassigned bugs
      end

      resources :users do
        resources :user_projects, only: [:index, :destroy]
      end

      resources :code_pieces
      resources :bugs, only: %i[update create]
      resources :features, only: %i[update create]

      resources :user_projects, only: [:create, :show] #using show action to show unassigned Projects

      resources :code_piece_users, except: [:index] #show is for assigned bugs

      # get '/userprojects/:id', to: 'user_projects#index', as: :user_projects_show
      # get '/userprojects/unassigned/:id', to: 'user_projects#unassigned', as: :user_projects_unassigned_show
      get '/userprojects/viewprojects/:id', to: 'user_projects#view_projects', as: :view_projects

      # get '/bugs/index/:id', to: 'code_pieces#index', as: :bugs_index
      # get '/bugs/:userid/unassigned/:id', to: 'code_piece_users#unassigned', as: :bugs_unassigned_list
      # get '/bugs/:userid/assigned/:id', to: 'code_piece_users#assigned', as: :bugs_assigned_list
      # get '/bugs/:userid/assign/:id', to: 'code_piece_users#assign', as: :bugs_assign
      # get '/bugs/:userid/remove/:id', to: 'code_piece_users#remove', as: :bugs_remove
      # get "/bugs/:id", to: "code_pieces#show", as: :bugs_show

      # get "/projects/:project_id/bugs/new", to: "bugs#new", as: :bugs_new
      # get "/projects/:project_id/features/new", to: "features#new", as: :features_new
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
