# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { described_class.new(name: 'Project2') }

  describe 'Associations' do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:user_projects).dependent(:destroy) }
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
  # it 'is invalid when user_id is absent' do
  #   project1=create(:project)
  #   expect(project1).to_not be_valid
  # end

  # describe 'Enums' do
  #   it { should define_enum_for(:status).with_values(%i[incomplete completed]) }
  # end

  # it 'is valid with valid attributes' do
  #   expect(subject).to be_valid
  # end

  # it 'is not valid without a title' do
  #   subject.title = nil
  #   expect(subject).to_not be_valid
  # end

  # it 'is not valid without a deadline' do
  #   subject.deadline = nil
  #   expect(subject).to_not be_valid
  # end

  # it 'is not valid if the deadline is not a date' do
  #   subject.deadline = '1234'
  #   expect(subject).to_not be_valid
  # end

  # it 'is not valid without a status' do
  #   subject.status = nil
  #   expect(subject).to_not be_valid
  # end
end
