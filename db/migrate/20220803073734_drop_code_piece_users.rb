class DropCodePieceUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :code_piece_users
  end
end
