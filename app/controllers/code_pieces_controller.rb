class CodePiecesController < ApplicationController
  def index
    @bugs=Bug.find(user_id: params[:id])
  end
end
