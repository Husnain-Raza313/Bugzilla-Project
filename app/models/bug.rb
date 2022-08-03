class Bug < ApplicationRecord
  belongs_to :project, optional: true # it allows foreign_key to be null
  belongs_to :user, optional: true
  # belongs_to :user, optional: true
  has_many :bug_users, dependent: :destroy
  has_many :users, through: :bug_users

  # validates :type, presence: true
  validates :title, presence: true, length: { maximum: 40, minimum: 5 }

  mount_uploader :screenshot, ScreenshotUploader

  # validates_uniqueness_of :title, scope: %i[user_id project_id]
  validates :title, uniqueness: { scope: %i[project_id] }

  enum piece_status: { new: 0, started: 1, resolved: 2 }, _prefix: :piece_status
end
