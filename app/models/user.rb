# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :bugs, inverse_of: :user, foreign_key: :qa_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 40, minimum: 2 }

  enum user_type: { manager: 0, developer: 1, qa: 2 }
  after_initialize :set_default_user_type, if: :new_record?

  def set_default_user_type
    self.user_type ||= :user
  end
end
