class AddTypeToCodePieces < ActiveRecord::Migration[5.2]
  def change
    add_column :code_pieces, :type, :string
  end
end
