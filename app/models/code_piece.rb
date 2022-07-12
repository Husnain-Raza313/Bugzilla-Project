class CodePiece < ApplicationRecord
  belongs_to :project
  belongs_to :user

  # validates_presence_of :type

  # mount_uploader :screenshot, ScreenshotUploader


end
