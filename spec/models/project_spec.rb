# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  subject(:project) { described_class.new(name: 'Project2') }

  describe 'Associations' do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:user_projects).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  it 'is valid when user_id is present' do
    user = create(:user)
    project1 = create(:project, user_id: user.id)
    expect(project1).to be_valid
  end
end
