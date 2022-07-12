class CodePiecesController < ApplicationController
  def index
    @bugs=Bug.where(user_id: params[:id])
    puts @bugs.ids
  end
end
