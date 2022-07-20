# frozen_string_literal: true

class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[update]

  def create
    @feature = Feature.new(feature_params)
    authorize @feature, policy_class: CodePiecePolicy
    respond_to do |format|
      if @feature.save

        format.html { redirect_to code_piece_url(@feature), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @feature }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @feature, policy_class: CodePiecePolicy
    respond_to do |format|
      if @feature.update(feature_params)
        format.html { redirect_to code_piece_url(@feature.id), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @feature }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @bug = Feature.new(project_id: params[:project_id])

    authorize @bug, policy_class: CodePiecePolicy

    render 'code_pieces/new'
  end

  private

  def set_feature
    @feature = Feature.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def feature_params
    if current_user.developer?
      params.require(:feature).permit(:piece_status)
    else
      params.require(:feature.permit(:piece_status, :description, :title, :project_id, :deadline, :screenshot, :type))
    end
  end
end
