# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Developer::Bugs', type: :request do
  include Devise::Test::IntegrationHelpers

  subject(:bug) { create(:bug, qa_id: qa_user.id, project_id: userproject13.project_id) }

  let(:manager) { create(:user) }
  let(:dev_user) { create(:random_user, :developer) }
  let(:qa_user) { create(:random_user, :qa) }

  let(:project13) { create(:project, user_id: manager.id) }
  let(:userproject13) { create(:user_project, user_id: qa_user.id, project_id: project13.id) }
  let(:userproject14) { create(:user_project, user_id: dev_user.id, project_id: project13.id) }

  describe 'GET developer::Bugs#index' do
    context 'when the user is manager' do
      it 'does not authorize accessing index' do
        sign_in manager
        get developer_bugs_path
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is qa' do
      it 'does not authorize accessing index' do
        sign_in qa_user
        get developer_bugs_path
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'accessing index with status all' do
        sign_in dev_user
        get developer_bugs_path(status: 'all')
        expect(response).to render_template(:index)
      end

      it 'accessing index with status assigned' do
        sign_in dev_user
        get developer_bugs_path(status: 'assigned')
        expect(response).to render_template(:assigned)
      end
    end
  end

  describe 'GET Developer::Bugs#project_bugs' do
    context 'when the user is manager' do
      it 'does not authorize accessing project_bugs action' do
        sign_in manager
        get project_bugs_path(project13.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is qa' do
      it 'does not authorize accessing project_bugs action' do
        sign_in qa_user
        get project_bugs_path(project13.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'accessing project_bugs with status unassigned' do
        sign_in dev_user
        get project_bugs_path(userproject14.project_id, status: 'unassigned')
        expect(response).to render_template(:unassigned)
      end

      it 'accessing project_bugs with status assigned' do
        bug = create(:bug, qa_id: qa_user.id, project_id: userproject14.project_id, developer_ids: [dev_user.id])
        sign_in dev_user
        get project_bugs_path(bug.project_id, status: 'assigned')
        expect(response).to render_template(:project_bugs)
      end

      it 'does not list unassigned bugs of unassigned projects' do
        project = create(:project, user_id: manager.id, name: 'Project456')
        sign_in dev_user
        get project_bugs_path(project.id, status: 'unassigned')
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end

      it 'does not list assigned bugs of unassigned projects' do
        project = create(:project, user_id: manager.id, name: 'Project55')
        sign_in dev_user
        get project_bugs_path(project.id, status: 'assigned')
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'GET Developer::Bugs#new' do
    context 'when the user is manager' do
      it 'does not authorize accessing new action' do
        sign_in manager
        get new_developer_bug_path(bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is qa' do
      it 'does not authorize accessing new action' do
        sign_in qa_user
        get new_developer_bug_path(bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'accessing new action with an assigned project bug' do
        bug = create(:bug, qa_id: qa_user.id, project_id: userproject14.project_id)
        sign_in dev_user
        get new_developer_bug_path(id: bug.id)
        expect(flash[:success]).to match('Bug was successfully Assigned.')
      end

      it 'accessing new action with an unassigned project bug' do
        project = create(:project, user_id: manager.id, name: 'Project456')
        bug = create(:bug, qa_id: qa_user.id, project_id: project.id)
        sign_in dev_user
        get new_developer_bug_path(id: bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end

  describe 'GET Developer::Bugs#destroy' do
    context 'when the user is manager' do
      it 'does not authorize accessing destroy action' do
        sign_in manager
        delete developer_bug_path(bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is qa' do
      it 'does not authorize accessing destroy action' do
        sign_in qa_user
        delete developer_bug_path(bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end

    context 'when the user is developer' do
      it 'accessing destroy action with an assigned project bug' do
        bug = create(:bug, qa_id: qa_user.id, project_id: userproject14.project_id, developer_ids: [dev_user.id])
        sign_in dev_user
        delete developer_bug_path(id: bug.id)
        expect(flash[:success]).to match('Bug was successfully unassigned.')
      end

      it 'accessing destroy action with an unassigned project bug' do
        project = create(:project, user_id: manager.id, name: 'Project456')
        bug = create(:bug, qa_id: qa_user.id, project_id: project.id)
        sign_in dev_user
        delete developer_bug_path(id: bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end

      it 'accessing destroy action with an assigned project bug for an unassigned bug' do
        bug = create(:bug, qa_id: qa_user.id, project_id: userproject14.project_id, developer_ids: [])
        sign_in dev_user
        delete developer_bug_path(id: bug.id)
        expect(flash[:error]).to match('You are not authorized to perform this action.')
      end
    end
  end
end
