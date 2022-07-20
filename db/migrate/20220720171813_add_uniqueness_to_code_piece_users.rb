# frozen_string_literal: true

class AddUniquenessToCodePieceUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :code_piece_users, %i[code_piece_id user_id], unique: true
  end
end
