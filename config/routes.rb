Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :bugs, only: %i[index show]
      resources :projects, only: %i[index show]
    end
  end

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root

      resources :projects do
        resources :bugs, only: %i[new]
      end

      resources :users
      resources :bugs, except: %i[new]
      resources :user_projects, except: %i[new update edit]

      namespace :developer do
        resources :bugs, only: %i[index new destroy]
      end

      get '/userprojects/viewprojects', to: 'user_projects#view_projects', as: :view_projects
      get '/project/bugs/:project_id', to: 'developer/bugs#project_bugs', as: :project_bugs
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
