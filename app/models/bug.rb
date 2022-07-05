class Bug < CodePiece
  enum piece_status: [:new, :started, :resolved], _prefix: :piece_status
  belongs_to :project
  validates :piece_status, inclusion: { in: [:new, :started, :resolved] }

end
