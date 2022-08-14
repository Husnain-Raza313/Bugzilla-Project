# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(id: 1, name: 'Manager2', email: 'manager2@email.com', password: 'test@123', user_type: 1)
  end

  # describe 'Creation' do
  #   it 'has one user created' do
  #     user=create(:user)
  #     expect(described_class.all.count).to eq(1)
  #   end
  # end
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
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:user_type).with_values(%i[manager developer qa]) }
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).not_to be_valid
  end

  it 'default user_type is manager' do
    user = create(:user)
    expect(user.user_type).to eq('manager')
  end
  # describe 'Validations' do
  #   it 'when user is created without name' do
  #     :user_manager.name = nil
  #     expect(:user_manager).not_to be_valid
  #   end

  #   it 'does not let a user be created with name more than forty letters' do
  #     user_manager.name = 'Helishlfassdfalhasdlfsdasfjsafslfdjksf;djdfsa;asfjsf'
  #     expect(user_manager).not_to be_valid
  #   end

  #   it 'lets a user be created with name less than forty letters' do
  #     user_manager.name = 'Charlie and The Chocolate Factory'
  #     expect(user_manager).to be_valid
  #   end

  #   it 'does not let a user be created without a password' do
  #     user_manager.password = ''
  #     expect(user_manager).not_to be_valid
  #   end

  #   it 'does not let a user be created with password less than eight characters' do
  #     user_manager.password = 'test'
  #     expect(user_manager).not_to be_valid
  #   end

  #   it 'lets a user be created with password more than seven characters' do
  #     user_manager.password = 'test@123'
  #     expect(user_manager).to be_valid
  #   end

  #   it 'does not let a user be created without email address' do
  #     user_manager.email = nil
  #     expect(user_manager).not_to be_valid
  #   end

  #   it "user's email is considered invalid if it is not in email format" do
  #     user_manager.email = 'useremail.com'
  #     expect(user_manager).not_to be_valid
  #   end

  #   it "user's email is considered invalid if it is not unique" do
  #     user_manager.email = 'manager2@email.com'
  #     expect(user_manager).not_to be_valid
  #   end

  #   it 'user be created as a manager if user_type is default' do
  #     expect(user_without_type.user_type).to eq('manager')
  #   end

  #   it 'user be created as a manager if user_type is selected as manager(index 0)' do
  #     user1 = described_class.create!(name: 'Manager1', email: 'manager5@email.com', password: 'manager123',
  #                                     user_type: 0)
  #     expect(user1.user_type).to eq('manager')
  #   end

  #   it 'user be created as a developer if user_type is selected as developer(index 1)' do
  #     user1 = described_class.create!(name: 'DEV1', email: 'dev1@email.com', password: 'developer123', user_type: 1)
  #     expect(user1.user_type).to eq('developer')
  #   end

  #   it 'user be created as a manager if user_type is selected as QA(index 2) ' do
  #     user1 = described_class.create!(name: 'QA1', email: 'qa1@email.com', password: 'qa@12345', user_type: 2)
  #     expect(user1.user_type).to eq('qa')
  #   end
  # end

  # describe 'Associations' do
  #   it 'has many user_projects' do
  #     t = described_class.reflect_on_association(:user_projects)
  #     expect(t.macro).to eq(:has_many)
  #   end

  #   it 'has many projects' do
  #     t = described_class.reflect_on_association(:projects)
  #     expect(t.macro).to eq(:has_many)
  #   end

  #   it 'has one Bug' do
  #     t = described_class.reflect_on_association(:bugs_as_qa)
  #     expect(t.macro).to eq(:has_many)
  #   end

  #   it 'decreases number of bugs' do
  #     expect { qa_user.destroy }.to change(Bug, :count)
  #   end

  #   it 'decreases number of userprojects records' do
  #     qa_user = described_class.create!(name: 'QA123', email: 'qa124@email.com', password: 'test@123', user_type: 2)
  #     expect { qa_user.destroy }.to change(UserProject, :count)
  #   end
  # end
end
