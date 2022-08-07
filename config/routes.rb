Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root

      resources :projects do
        resources :bugs, only: [:new, :index]
      end

      resources :users do
        resources :user_projects, only: [:index, :destroy]
      end

      resources :bugs, except: [:new]
      resources :user_projects, only: [:create, :show]

      get '/userprojects/viewprojects', to: 'user_projects#view_projects', as: :view_projects
      get '/assigned/:id', to: 'bugs#assigned', as: :assigned_bugs

    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
