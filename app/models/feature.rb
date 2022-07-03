class Feature < CodePiece
  enum status: [:new, :started, :completed]

  validates :status, inclusion: { in: [:new, :started, :completed] }
end
