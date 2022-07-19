class CodePieceUser < ApplicationRecord
  belongs_to :user
  belongs_to :code_piece

  # belongs_to :project


  validates_uniqueness_of :code_piece_id, scope: %i[user_id]
end
