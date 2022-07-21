# frozen_string_literal: true

class CodePiece < ApplicationRecord
  belongs_to :project, optional: true # it allows foreign_key to be null
  # belongs_to :user, optional: true
  has_many :code_piece_users, dependent: :destroy
  has_many :users, through: :code_piece_users

  validates :type, presence: true
  validates :title, presence: true

  mount_uploader :screenshot, ScreenshotUploader

  # validates_uniqueness_of :title, scope: %i[user_id project_id]
  validates :title, uniqueness: { scope: %i[project_id] }
end
