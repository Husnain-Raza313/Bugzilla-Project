# frozen_string_literal: true

class ChangeStatusColumnNameInCodePiece < ActiveRecord::Migration[5.2]
  def change
    rename_column :code_pieces, :status, :piece_status
  end
end
