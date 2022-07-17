class FeaturesController < ApplicationController


    before_action :set_feature, only: %i[ edit update  new]

    def create
      @feature = Feature.new(feature_params)

      respond_to do |format|
        if @feature.save

          format.html { redirect_to bugs_show_url(@feature), notice: "Project was successfully created." }
          format.json { render :show, status: :created, location: @feature }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @feature.errors, status: :unprocessable_entity }
        end
      end
    end
    def update
      respond_to do |format|
        puts " Here is the    #{feature_params.inspect}"
        if @feature.update(feature_params)
          format.html { redirect_to bugs_show_url(@feature.id), notice: "Project was successfully updated." }
          format.json { render :show, status: :ok, location: @feature }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @feature.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def new
      @bug = Feature.new(project_id: params[:project_id])
    end

    def set_feature
      @feature = Feature.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feature_params
      params.require(:feature).permit(:piece_status, :description, :title, :project_id, :deadline, :screenshot, :type)
    end



end
