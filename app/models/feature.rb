# frozen_string_literal: true

class Feature < CodePiece
  enum piece_status: { new: 0, started: 1, completed: 2 }, _prefix: :piece_status
end
