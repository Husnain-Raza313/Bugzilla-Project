# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_one :bugs_as_qa, class_name: 'Bug', foreign_key: 'qa_id',
                       dependent: nil, inverse_of: :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { manager: 0, developer: 1, qa: 2 }
  after_initialize :set_default_user_type, if: :new_record?

  def set_default_user_type
    self.user_type ||= :user
  end
end
