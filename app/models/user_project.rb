# frozen_string_literal: true

class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :user_search, -> (current_user){ where(user_id: current_user).pluck(:project_id)}
end
