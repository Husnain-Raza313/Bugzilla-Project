# frozen_string_literal: true

class User < ApplicationRecord
  # has_many :bugs, dependent: :nullify
  has_many :bug_users, dependent: :destroy
  has_many :bugs, through: :bug_users

  has_many :bugs_as_qa, class_name: 'Bug', foreign_key: 'qa_id'
  has_many :bugs_as_developer, class_name: 'Bug', foreign_key: 'developer_id'
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { manager: 0, developer: 1, qa: 2 }
  after_initialize :set_default_user_type, if: :new_record?

  def set_default_user_type
    self.user_type ||= :user
  end
end
