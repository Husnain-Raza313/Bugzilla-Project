# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    described_class.new(id: 1, name: 'Manager2', email: 'manager2@email.com', password: 'test@123', user_type: 1)
  end

  describe 'Associations' do
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_many(:user_projects).dependent(:destroy) }
    it { is_expected.to have_many(:bugs).with_foreign_key('qa_id') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_length_of(:name).is_at_least(2) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:user_type).with_values(%i[manager developer qa]) }
  end

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without a email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).not_to be_valid
  end

  it 'default user_type is manager' do
    user1 = create(:user)
    expect(user1.user_type).to eq('manager')
  end
end
