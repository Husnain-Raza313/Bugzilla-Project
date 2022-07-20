# frozen_string_literal: true

class AddUniquenessToCodePieces < ActiveRecord::Migration[5.2]
  def change
    add_index :code_pieces, %i[title project_id], unique: true
  end
end
