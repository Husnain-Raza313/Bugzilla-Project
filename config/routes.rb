Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :bugs, only: %i[index show]
      resources :projects, only: %i[index show]
    end
  end

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root

      resources :projects do
        resources :bugs, only: %i[new]
      end

      resources :users
      resources :bugs, except: %i[new] do
        collection do
          get :autocomplete
        end
      end
      resources :user_projects, except: %i[new update edit]

      namespace :developer do
        resources :bugs, only: %i[index new destroy]
      end

      get '/userprojects/viewprojects', to: 'user_projects#view_projects', as: :view_projects
      get '/project/bugs/:project_id', to: 'developer/bugs#project_bugs', as: :project_bugs
      post 'checkout/create', to: 'checkout#create'
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
