class CodePiece < ActiveRecord
  belongs_to :project

  mount_uploader :screenshot, ScreenshotUploader


end
