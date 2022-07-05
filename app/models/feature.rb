class Feature < CodePiece
   enum piece_status: [:new, :started, :completed]
  belongs_to :project
   validates :piece_status, inclusion: { in: [:new, :started, :completed] }
end
