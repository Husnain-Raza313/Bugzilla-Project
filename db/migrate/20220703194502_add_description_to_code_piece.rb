class AddDescriptionToCodePiece < ActiveRecord::Migration[5.2]
  def change
    add_column :code_pieces, :description, :string
  end
end
