class CodePiece < ApplicationRecord
  belongs_to :project, optional: true #it allows foreign_key to be null
  belongs_to :user, optional: true

  validates_presence_of :type

  mount_uploader :screenshot, ScreenshotUploader

  validates_uniqueness_of :title, scope: %i[user_id project_id]


end
