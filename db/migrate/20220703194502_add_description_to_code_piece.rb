# frozen_string_literal: true

class AddDescriptionToCodePiece < ActiveRecord::Migration[5.2]
  def change
    add_column :code_pieces, :description, :text
  end
end
