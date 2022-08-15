# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include Devise::Test::IntegrationHelpers
  describe 'GET /index' do
    let(:manager) { create(:user) }
    # let(:second_manager) { create(:user, :manager) }
    let(:dev_user) { create(:random_user, :developer) }
    let(:qa_user) { create(:random_user, :qa) }
    # let(:m1_projects) { create_list(:project, 5, :incomplete, :deadline_in_future, project_manager: first_manager) }
    # let(:m2_projects) { create_list(:project, 5, :incomplete, :deadline_in_future, project_manager: second_manager) }

    context 'when the user is manager' do
      it 'lists all the users' do
        sign_in manager
        get users_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is developer or QA ' do
      it 'does not list all the users to Developer' do
        sign_in dev_user
        get users_path
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end

      it 'does not list all the users to QA' do
        sign_in qa_user
        get users_path
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'GET users#show' do
    context 'when the user is manager' do
      it 'renders show template' do
        current = create(:user)
        sign_in current
        dev_user = create(:random_user, :developer)
        get user_path(dev_user.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is a developer' do
      it 'does not render show template' do
        current = create(:random_user, :developer)
        sign_in current
        qa_user = create(:random_user, :qa)
        get user_path(qa_user.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is a QA' do
      it 'does not render show template' do
        current = create(:random_user, :qa)
        sign_in current
        dev_user = create(:random_user, :developer)
        get user_path(dev_user.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'GET users#edit' do

    context 'when user is not logged in' do
      it 'renders login page(unauthenticated root path)' do
        get edit_user_registration_path
        expect(response).to redirect_to(user_session_path)
      end
    end
    context 'when logged-in user edits details' do
      it 'renders edit template for manager' do
        current = create(:user)
        sign_in current
        get edit_user_registration_path
        expect(response).to have_http_status(:ok)
      end

      it 'renders edit template for developer' do
        current = create(:random_user, :developer)
        sign_in current
        get edit_user_registration_path
        expect(response).to have_http_status(:ok)
      end

      it 'renders edit template for qa' do
        current = create(:random_user, :qa)
        sign_in current
        get edit_user_registration_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET Root path' do
    context 'when user is not logged in' do
      it 'renders login page(unauthenticated root path)' do
        get '/'
        expect(response).to render_template(:new)
      end
    end

    context 'when user is logged in' do
      it 'renders login page(authenticated root path)' do
        current = create(:user)
        sign_in current
        get '/'
        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe 'POST devise/registrations#create' do
    context 'when the user is signing up' do
      let(:params) do
        { user: { email: 'manager99@email.com', password: 'test@123', name: 'Manager', user_type: 'manager' } }
      end

      it 'creates the project with valid attributes' do
        expect do
          post user_registration_path, params: params
        end.to change(User, :count).by(1)
      end

      it 'is not able to create user without name' do
        params[:user][:name] = nil
        post user_registration_path, params: params
        expect(response.body).to include('Name can&#39;t be blank')
      end

      it 'is not able to create user without email' do
        params[:user][:email] = nil
        post user_registration_path, params: params
        expect(response.body).to include('Email can&#39;t be blank')
      end

      it 'is not able to create user without password' do
        params[:user][:password] = nil
        post user_registration_path, params: params
        expect(response.body).to include('Password can&#39;t be blank')
      end

      it 'is not able to create user with empty password confirmation field' do
        params[:user][:password_confirmation] = ''
        post user_registration_path, params: params
        expect(response.body).to include('doesn&#39;t match Password')
      end

      it 'is not able to create user with invalid password confirmation' do
        params[:user][:password_confirmation] = 'test'
        post user_registration_path, params: params
        expect(response.body).to include('doesn&#39;t match Password')
      end

      it 'is not able to create user with invalid email format' do
        params[:user][:email] = 'manager'
        post user_registration_path, params: params
        expect(response.body).to include('Email is invalid')
      end

      it 'is not able to create user with less than minimum name characters(2)' do
        params[:user][:name] = 'm'
        post user_registration_path, params: params
        expect(response.body).to include('Name is too short')
      end

      it 'is not able to create user with more than max name characters(40)' do
        params[:user][:name] = 'mjfkdjslskdjdksjfksljfdsljfdslsdfjlsfdjfsdljfsdl'
        post user_registration_path, params: params
        expect(response.body).to include('Name is too long')
      end

      it 'is not able to create user with less than minimum password characters(8)' do
        params[:user][:password] = 'test'
        post user_registration_path, params: params
        expect(response.body).to include('Password is too short')
      end
      it 'is not able to create user with email already used' do
        user=create(:user)
        params[:user][:email] = "manager4@email.com"
        post user_registration_path, params: params
        expect(response.body).to include('Email has already been taken')
      end
    end
  end

  describe 'PUT devise/registrations#update' do
    context 'when user is not logged in' do
      it 'renders login page(unauthenticated root path)' do
        put user_registration_path
        expect(response).to redirect_to(user_session_path)
      end
    end
    context 'when the logged-in user is a manager' do
     let(:current) { create(:user) }
     let(:params) do
      { user: { email: 'manager786@email.com', name: 'Manager786', user_type: 'developer', password: current.password, password_confirmation: current.password, current_password: current.password } }
    end
     before do
      sign_in current
    end


      it 'updates the user with valid attributes' do
          put user_registration_path, params: params
          expect(flash[:notice]).to match('Your account has been updated successfully.')
      end
      it 'updates the user_type with the developer' do
        puts current.name
        put user_registration_path, params: params
        expect(current.user_type).to eq('developer')
    end

      it 'is not able to update user without name' do
        params[:user][:name] = nil
        put user_registration_path, params: params
        expect(response.body).to include('Name can&#39;t be blank')
      end

      it 'is not able to update user without email' do
        params[:user][:email] = nil
        put user_registration_path, params: params
        expect(response.body).to include('Email can&#39;t be blank')
      end

      it 'is able to create user without current password' do
        params[:user][:current_password] = nil
        put user_registration_path, params: params
        expect(response.body).to include('Current password can&#39;t be blank')
      end

      it 'is not able to update user with empty password confirmation field' do
        params[:user][:password] = 'test@123'
        params[:user][:password_confirmation] = ''
        put user_registration_path, params: params
        expect(response.body).to include('doesn&#39;t match Password')
      end

      it 'is not able to update user with invalid password confirmation' do
        params[:user][:password] = 'test@123'
        params[:user][:password_confirmation] = 'test1234'
        put user_registration_path, params: params
        expect(response.body).to include('doesn&#39;t match Password')
      end

      it 'is not able to update user with invalid email format' do
        params[:user][:email] = 'manager'
        put user_registration_path, params: params
        expect(response.body).to include('Email is invalid')
      end

      it 'is not able to update user with less than minimum name characters(2)' do
        params[:user][:name] = 'm'
        put user_registration_path, params: params
        expect(response.body).to include('Name is too short')
      end

      it 'is not able to create user with more than max name characters(40)' do
        params[:user][:name] = 'mjfkdjslskdjdksjfksljfdsljfdslsdfjlsfdjfsdljfsdl'
        put user_registration_path, params: params
        expect(response.body).to include('Name is too long')
      end

      it 'is not able to update user with less than minimum password characters(6)' do
        params[:user][:password] = 'test'
        put user_registration_path, params: params
        expect(response.body).to include('Password is too short')
      end
      it 'is not able to update user with email already used' do
        user=create(:random_user)
        params[:user][:email] = "manager9@email.com"
         put user_registration_path, params: params
        expect(response.body).to include('Email has already been taken')
      end
    end
  end


end
