# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bug, type: :model do
  subject(:bug) do
    described_class.new(id: 1, title: 'Bug12314', deadline: '2022-06-29', piece_status: 'new', piece_type: 'Bug',
                        project_id: project1.id, qa_id: project1.user_id)
  end

  let(:user1) { create(:user) }
  let(:project1) { create(:project, user_id: user1.id) }
  let(:project2) { create(:project, name: 'Project2', user_id: user1.id) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:piece_status) }
    it { is_expected.to validate_presence_of(:piece_type) }

    it 'checks title and project_id uniqueness' do
      expect(bug).to validate_uniqueness_of(:title).ignoring_case_sensitivity.scoped_to(:project_id)
    end
  end

  describe 'Enums' do
    it {
      expect(bug).to define_enum_for(:piece_status).with_values(%i[new started resolved]).with_prefix(:piece_status)
    }
  end

  it 'is valid with valid attributes' do
    expect(bug).to be_valid
  end

  it 'is valid if title is same in another project' do
    create(:bug, title: 'Bug12314', project_id: project2.id, qa_id: project2.user_id)
    expect(bug).to be_valid
  end

  it 'is not valid without a title' do
    bug.title = nil
    expect(bug).not_to be_valid
  end

  it 'is not valid without a piece_type' do
    bug.piece_type = nil
    expect(bug).not_to be_valid
  end

  it 'is not valid without foreign keys' do
    bug.project_id = nil
    bug.qa_id = nil
    expect(bug).not_to be_valid
  end

  it 'is not valid if title is not unique in a same project' do
    create(:bug, title: 'Bug12314', project_id: project1.id, qa_id: project1.user_id)
    expect(bug).not_to be_valid
  end

  it 'is not valid without a status' do
    bug.piece_status = nil
    expect(bug).not_to be_valid
  end
end
