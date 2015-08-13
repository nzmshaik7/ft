class UpgradeTypesController < ApplicationController

    before_filter :database_area

    # GET /upgrade_types
    # GET /upgrade_types.json
    def index
        @upgrade_types = UpgradeType.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @upgrade_types }
        end
    end

    # GET /upgrade_types/1
    # GET /upgrade_types/1.json
    def show
        @upgrade_type = UpgradeType.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @upgrade_type }
        end
    end

    # GET /upgrade_types/new
    # GET /upgrade_types/new.json
    def new
        @upgrade_type = UpgradeType.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @upgrade_type }
        end
    end

    # GET /upgrade_types/1/edit
    def edit
        @upgrade_type = UpgradeType.find(params[:id])
    end

    # POST /upgrade_types
    # POST /upgrade_types.json
    def create
        @upgrade_type = UpgradeType.new(params[:upgrade_type])

        respond_to do |format|
            if @upgrade_type.save
                format.html { redirect_to upgrade_types_url,
                              notice: 'UpgradeType was successfully created.' }
                format.json { render json: @upgrade_type, status: :created, location: @upgrade_type }
            else
                format.html { render action: "new" }
                format.json { render json: @upgrade_type.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /upgrade_types/1
    # PUT /upgrade_types/1.json
    def update
        @upgrade_type = UpgradeType.find(params[:id])

        respond_to do |format|
            if @upgrade_type.update_attributes(params[:upgrade_type])
                format.html { redirect_to upgrade_types_url,
                              notice: 'UpgradeType was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @upgrade_type.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /upgrade_types/1
    # DELETE /upgrade_types/1.json
    def destroy
        @upgrade_type = UpgradeType.find(params[:id])
        @upgrade_type.destroy

        respond_to do |format|
            format.html { redirect_to upgrade_types_url }
            format.json { head :no_content }
        end
    end
end
