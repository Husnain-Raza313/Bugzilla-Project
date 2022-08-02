# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root


      resources :projects do
        resources :code_pieces, only: [:new]
        resources :code_piece_users, only: [:index] #index is for unassigned bugs
      end

      resources :users do
        resources :user_projects, only: [:index, :destroy]
      end

      resources :code_pieces, except: [:new]
      resources :user_projects, only: [:create, :show] #using show action to show unassigned Projects

      resources :code_piece_users, except: [:index] #show is for assigned bugs


      get '/userprojects/viewprojects', to: 'user_projects#view_projects', as: :view_projects


    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
