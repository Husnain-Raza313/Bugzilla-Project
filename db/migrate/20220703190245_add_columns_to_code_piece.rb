class AddColumnsToCodePiece < ActiveRecord::Migration[5.2]
  def change
    # add_column :code_pieces, :type, :integer, null: false, default: 0
    add_column :code_pieces, :status, :integer, null: false, default: 0
    add_column :code_pieces, :deadline, :date
  end
end
