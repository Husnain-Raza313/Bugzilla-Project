# frozen_string_literal: true

class ChangeNullTitleColumnInCodePieces < ActiveRecord::Migration[5.2]
  def change
    change_column_null :code_pieces, :title, false, Time.zone.now
  end
end
