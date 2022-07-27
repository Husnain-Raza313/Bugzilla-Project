class FixColumnNameInCodePieces < ActiveRecord::Migration[5.2]
  def change
    rename_column :code_pieces, :type, :piece_type
  end
end
