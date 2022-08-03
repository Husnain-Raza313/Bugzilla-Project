# frozen_string_literal: true

class CodePieceUser < ApplicationRecord
  belongs_to :user
  belongs_to :bug

  # belongs_to :project

  validates :code_piece_id, uniqueness: { scope: %i[user_id] }
end
