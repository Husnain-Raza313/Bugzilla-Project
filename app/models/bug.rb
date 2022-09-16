# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user, inverse_of: :bugs, foreign_key: :qa_id

  mount_uploader :screenshot, ScreenshotUploader

  validates :title, presence: true, length: { maximum: 40, minimum: 5 }
  validates :piece_type, presence: true
  validates :piece_status, presence: true
  validates :title, uniqueness: { scope: %i[project_id] }

  enum piece_status: { new: 0, started: 1, resolved: 2 }, _prefix: :piece_status

  searchkick word_middle: [:title]

  def search_data
    {
      title:title
    }
  end
end
