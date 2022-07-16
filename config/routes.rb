Rails.application.routes.draw do

  # get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
      # get '/projects/index', to: 'project#index'

      resources :projects
      get 'users/index'
      get "/users/:id", to: "users#show", as: :users_show
      get '/userprojects/:id', to: "user_projects#index", as: :user_projects_show
      get '/userprojects/unassigned/:id', to: "user_projects#unassigned", as: :user_projects_unassigned_show
      get '/userprojects/:userid/assign/:id', to: "user_projects#assign", as: :projects_assign
      get '/userprojects/:userid/remove/:id', to: "user_projects#remove", as: :projects_remove
      get '/userprojects/dev/:id', to: "user_projects#dev_view_projects", as: :dev_projects


      get '/bugs/index/:id', to: "code_pieces#index", as: :bugs_index
      get '/bugs/:userid/unassigned/:id', to: "code_pieces#unassigned", as: :bugs_unassigned_list
      get '/bugs/:userid/assigned/:id', to: "code_pieces#assigned", as: :bugs_assigned_list
      get '/bugs/:userid/assign/:id', to: "code_pieces#assign", as: :bugs_assign
      get '/bugs/:userid/remove/:id', to: "code_pieces#remove", as: :bugs_remove
      get "/bugs/:id", to: "code_pieces#show", as: :bugs_show
      resources :code_pieces
      resources :bugs
      resources :features
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root

    end
  end

end
