class CodePiece < ApplicationRecord
  belongs_to :project
  belongs_to :user

  mount_uploader :screenshot, ScreenshotUploader


end
