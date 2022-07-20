# frozen_string_literal: true

class Bug < CodePiece
  enum piece_status: { new: 0, started: 1, resolved: 2 }, _prefix: :piece_status
end
