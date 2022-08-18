# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bugs', type: :request do
  include Devise::Test::IntegrationHelpers

  subject(:bug) { create(:bug, qa_id: qa_user.id, project_id: userproject13.project_id) }

  let(:manager) { create(:user) }
  let(:dev_user) { create(:random_user, :developer) }
  let(:qa_user) { create(:random_user, :qa) }
  let(:project13) { create(:project, user_id: manager.id) }
  let(:userproject13) { create(:user_project, user_id: qa_user.id, project_id: project13.id) }
  let(:qa_user2) { create(:random_user, :qa2) }
  let(:userproject14) { create(:user_project, user_id: qa_user2.id, project_id: project13.id) }

  describe 'GET /index' do
    context 'when the user is manager' do
      it 'does not authorize accessing index' do
        sign_in manager
        get bugs_path
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'does not authorize accessing index' do
        sign_in dev_user
        get bugs_path
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is qa' do
      it 'accessing index with status all' do
        sign_in qa_user
        get bugs_path(status: 'all')
        expect(response).to render_template(:index)
      end

      it 'accessing index with status assigned' do
        sign_in qa_user
        get bugs_path(status: 'assigned')
        expect(response).to render_template(:assigned)
      end
    end
  end

  describe 'GET Bugs#show' do
    context 'when the user is manager' do
      it 'does not authorize accessing show' do
        sign_in manager
        get bug_path(bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      let(:userproject14) { create(:user_project, user_id: dev_user.id, project_id: project13.id) }

      it 'does not authorize accessing show' do
        bug.project_id = userproject14.project_id
        sign_in dev_user
        get bug_path(bug.id)
        expect(response).to render_template(:show)
      end
    end

    context 'when the user is qa' do
      it 'authorize accessing show' do
        sign_in qa_user
        get bug_path(bug.id)
        expect(response).to render_template(:show)
      end

      it 'does not authorize accessing show for a bug not belongs to qa' do
        bug2 = create(:bug, title: 'Bug4561', qa_id: qa_user2.id, project_id: userproject14.project_id)
        sign_in qa_user
        get bug_path(bug2.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'GET Bugs#new' do
    context 'when the user is manager' do
      it 'does not authorize accessing new' do
        sign_in manager
        get new_project_bug_path(project13.id, bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'does not authorize accessing new' do
        sign_in dev_user
        get new_project_bug_path(project13.id, bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is QA' do
      it 'authorize accessing new' do
        sign_in qa_user
        get new_project_bug_path(project13.id, bug.id)
        expect(response).to render_template(:new)
      end

      it 'does not authorize accessing new for a bug belongs to other QA' do
        bug2 = create(:bug, title: 'Bug4561', qa_id: qa_user2.id, project_id: userproject14.project_id)
        sign_in qa_user
        get new_project_bug_path(project13.id, bug2.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'GET Bugs#edit' do
    let(:bug1) { create(:bug, qa_id: qa_user.id, project_id: project13.id, developer_ids: [dev_user.id]) }

    context 'when the user is manager' do
      it 'does not authorize accessing edit' do
        sign_in manager
        get edit_bug_path(bug1.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'authorizes accessing edit' do
        sign_in dev_user
        get edit_bug_path(bug1.id)
        expect(response).to render_template(:edit)
      end
    end

    context 'when the user is QA' do
      it 'authorizes accessing edit' do
        sign_in qa_user
        get edit_bug_path(bug1.id)
        expect(response).to render_template(:edit)
      end

      it 'does not authorize accessing edit of another QA bug' do
        bug2 = create(:bug, title: 'Bug4561', qa_id: qa_user2.id, project_id: userproject14.project_id)
        sign_in qa_user
        get edit_bug_path(bug2.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'PUT Bugs#update' do
    let(:bug1) { create(:bug, qa_id: qa_user.id, project_id: project13.id, developer_ids: [dev_user.id]) }

    context 'when the user is manager' do
      it 'does not authorize accessing update' do
        sign_in manager
        put bug_path(bug1.id, params: { bug:
          { piece_status: 'started' } })
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'authorizes accessing update' do
        sign_in dev_user
        put bug_path(bug1.id, params: { bug:
          { piece_status: 'started' } })
        expect(flash[:success]).to match('Bug was successfully updated.')
      end
    end

    context 'when the user is QA' do
      let(:qa_user2) { create(:random_user, :qa2) }

      before do
        sign_in qa_user
      end

      it 'authorizes accessing update' do
        put bug_path(bug1.id, params: { bug:
          { title: 'Bug786' } })
        expect(flash[:success]).to match('Bug was successfully updated.')
      end

      it 'does not allow update bug with same title and project id' do
        create(:bug, :same, project_id: bug1.project_id, qa_id: qa_user.id)
        put bug_path(bug1.id, params: { bug: { title: 'Bug1234' } })
        expect(response.body).to include('has already been taken')
      end

      it 'doesnot authorize accessing update of another QA bug' do
        userproject14 = create(:user_project, user_id: qa_user2.id, project_id: project13.id)
        bug2 = create(:bug, qa_id: qa_user2.id, project_id: userproject14.project_id)
        put bug_path(bug2.id, params: { bug: { title: 'Bug786' } })
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'POST Bugs#create' do
    let(:bug1) { create(:bug, qa_id: qa_user.id, project_id: userproject13.project_id, developer_ids: [dev_user.id]) }
    let(:params) do
      { bug: {title: 'Bug123456', piece_status: 'new', piece_type: 'Bug',
               project_id: userproject13.project_id } }
    end

    context 'when the user is manager' do
      it 'does not authorize accessing create' do
        sign_in manager
        post bugs_path, params: params
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'does not authorize accessing create' do
        sign_in dev_user
        post bugs_path, params: params
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is qa' do
      let(:bug_params) do
        { bug:
        { title: 'Bug1234', piece_status: 'new', piece_type: 'Bug', project_id: userproject14.project_id } }
      end
      it 'authorize accessing create' do
        sign_in qa_user
        post bugs_path, params: params
        expect(flash[:success]).to match('Bug was successfully created.')
      end

      it 'does not allow create bug with same title and project id' do
        create(:bug, :same, project_id: userproject14.project_id, qa_id: qa_user2.id)
        sign_in qa_user2
        post bugs_path, params: bug_params
        expect(response.body).to include('has already been taken')
      end

      it 'does not authorize qa creating a bug for a project which is not assigned' do
        sign_in qa_user
        post bugs_path, params: bug_params
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'DELETE Bugs#destroy' do
    context 'when the user is manager' do
      it 'does not authorize accessing destroy' do
        sign_in manager
        delete bug_path(bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'does not authorize accessing destroy' do
        sign_in dev_user
        delete bug_path(bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is QA' do
      it 'authorizes accessing destroy' do
        sign_in qa_user
        delete bug_path(bug.id)
        flash[:success] = 'Bug was successfully destroyed.'
      end

      it 'does not authorize destroying a bug belongs to another QA' do
        bug2 = create(:bug, title: 'Bug4561', qa_id: qa_user2.id, project_id: userproject14.project_id)
        sign_in qa_user
        delete bug_path(bug2.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end
end
