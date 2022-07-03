class Bug < CodePiece
  enum status: [:new, :started, :resolved]

  validates :status, inclusion: { in: [:new, :started, :resolved] }

end
