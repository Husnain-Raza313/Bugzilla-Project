class Bug < CodePiece
  enum piece_status: [:new, :started, :resolved]
  belongs_to :project
  validates :piece_status, inclusion: { in: [:new, :started, :resolved] }

end
