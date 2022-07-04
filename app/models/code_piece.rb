class CodePiece < ApplicationRecord
  belongs_to :project

  mount_uploader :screenshot, ScreenshotUploader
  enum type: [:bug,:feature]


  validates title, unique: true
  validates :type, inclusion: { in: [:bug,:feature] }

end
