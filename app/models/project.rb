# frozen_string_literal: true

class Project < ApplicationRecord

  belongs_to :user

  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects

  has_many :code_pieces, dependent: :destroy

  validates :name, uniqueness: true, presence: true, length: { maximum: 40 , minimum: 5}
end
