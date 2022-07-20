# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects

  has_many :code_pieces, dependent: :destroy

  validates :name, uniqueness: true
end
