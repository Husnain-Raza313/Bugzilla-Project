class Feature < CodePiece
   enum piece_status: [:new, :started, :completed], _prefix: :piece_status
  belongs_to :project
   validates :piece_status, inclusion: { in: [:new, :started, :completed] }
end
