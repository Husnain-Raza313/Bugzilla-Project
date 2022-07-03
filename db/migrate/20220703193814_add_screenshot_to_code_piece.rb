class AddScreenshotToCodePiece < ActiveRecord::Migration[5.2]
  def change
    add_column :code_pieces, :screenshot, :string
  end
end
