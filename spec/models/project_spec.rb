# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  subject(:project) { described_class.new(name: 'Project2', user_id: user.id) }

  let(:user) { create(:user) }

  describe 'Associations' do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:user_projects).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  it 'is valid when all attributes are valid' do
    expect(project).to be_valid
  end

  it 'is not valid with same title' do
    create(:project, name: 'Project2', user_id: user.id)
    expect(project).not_to be_valid
  end

  it 'is not valid without foreign keys' do
    project.user_id = nil
    expect(project).not_to be_valid
  end
end
