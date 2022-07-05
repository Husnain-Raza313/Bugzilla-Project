class CodePiece < ApplicationRecord
  belongs_to :project

  mount_uploader :screenshot, ScreenshotUploader


end
