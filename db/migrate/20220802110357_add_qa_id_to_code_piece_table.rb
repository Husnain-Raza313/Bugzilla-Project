class AddQaIdToCodePieceTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :code_pieces, :user, index: true
  end
end
