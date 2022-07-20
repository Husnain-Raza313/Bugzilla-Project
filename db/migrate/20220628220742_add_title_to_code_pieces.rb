# frozen_string_literal: true

class AddTitleToCodePieces < ActiveRecord::Migration[5.2]
  def change
    add_column :code_pieces, :title, :string, null: false, default: ''
    add_index :code_pieces, :title, unique: true
  end
end
