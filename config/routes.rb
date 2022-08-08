Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root

      resources :projects do
        resources :bugs, only: [:new]
      end

      resources :users do
        resources :user_projects, only: [:index, :destroy]
      end

      resources :bugs, except: [:new]
      resources :user_projects, only: [:create, :show]

      namespace :developer do
        resources :bugs, only: [:index, :new, :destroy]
      end

      get '/userprojects/viewprojects', to: 'user_projects#view_projects', as: :view_projects
      get '/project/bugs/:project_id', to: 'developer/bugs#project_bugs', as: :project_bugs

    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
