# frozen_string_literal: true

class AddUserToCodePieces < ActiveRecord::Migration[5.2]
  def change
    add_reference :code_pieces, :user, foreign_key: true
  end
end
