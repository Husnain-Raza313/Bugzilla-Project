class Bug < CodePiece
  validates :title, presence: true
  validates :status, presence: true
end
