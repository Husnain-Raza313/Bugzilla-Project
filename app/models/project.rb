# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :bugs, dependent: :destroy

  validates :name, uniqueness: true, presence: true, length: { maximum: 40, minimum: 5 }

  searchkick text_middle: [:name]

  def search_data
    {
      name: name
    }
  end
end
