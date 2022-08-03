# frozen_string_literal: true

class BugUser < ApplicationRecord
  belongs_to :user
  belongs_to :bug

  # belongs_to :project

  validates :bug_id, uniqueness: { scope: %i[user_id] }
end
