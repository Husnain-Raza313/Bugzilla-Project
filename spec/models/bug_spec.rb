# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bug, type: :model do
  subject(:bug) do
    described_class.new(id: 1, title: 'Bug12314', deadline: '2022-06-29', piece_status: 'new', project_id: 1, qa_id: 2)
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }

    it 'checks title and project_id uniqueness' do
      user1 = create(:user)
      project1 = create(:project, user_id: user1.id)
      bug.project_id = project1.id
      bug.qa_id = project1.user_id
      expect(bug).to validate_uniqueness_of(:title).ignoring_case_sensitivity.scoped_to(:project_id)
    end
  end

  describe 'Enums' do
    it {
      expect(bug).to define_enum_for(:piece_status).with_values(%i[new started resolved]).with_prefix(:piece_status)
    }
  end

  it 'is valid with valid attributes' do
    user1 = create(:user)
    project1 = create(:project, user_id: user1.id)
    bug.project_id = project1.id
    bug.qa_id = project1.user_id
    expect(bug).to be_valid
  end

  it 'is not valid without a title' do
    bug.title = nil
    expect(bug).not_to be_valid
  end

  it 'is not valid if the deadline is not a date' do
    bug.deadline = '1234'
    expect(bug).not_to be_valid
  end

  it 'is not valid without a status' do
    bug.piece_status = nil
    expect(bug).not_to be_valid
  end
end
