class BgSystemCoveredsController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ] 
        }
        @bgSystems = BgSystem.all
        @bgSystemCollect = @bgSystems.collect { |p|
            [ p.name, p.id ] 
        }
    end

    # GET /bg_system_covereds
    # GET /bg_system_covereds.json
    def index
        @bg_system_covereds = BgSystemCovered.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @bg_system_covereds }
        end
    end

    # GET /bg_system_covereds/1
    # GET /bg_system_covereds/1.json
    def show
        @bg_system_covered = BgSystemCovered.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @bg_system_covered }
        end
    end

    # GET /bg_system_covereds/new
    # GET /bg_system_covereds/new.json
    def new
        @bg_system_covered = BgSystemCovered.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @bg_system_covered }
        end
    end

    # GET /bg_system_covereds/1/edit
    def edit
        @bg_system_covered = BgSystemCovered.find(params[:id])
        prepFormVariables
    end

    # POST /bg_system_covereds
    # POST /bg_system_covereds.json
    def create
        @bg_system_covered = BgSystemCovered.new(params.require(:bg_system_covered).permit(:coverage, :system_id, :vehicle_id))

        respond_to do |format|
            if @bg_system_covered.save
                format.html { redirect_to bg_system_covereds_url,
                              notice: 'BgSystemCovered was successfully created.' }
                format.json { render json: @bg_system_covered, status: :created, location: @bg_system_covered }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @bg_system_covered.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /bg_system_covereds/1
    # PUT /bg_system_covereds/1.json
    def update
        @bg_system_covered = BgSystemCovered.find(params[:id])

        respond_to do |format|
            if @bg_system_covered.update_attributes(params.require(:bg_system_covered).permit(:coverage, :system_id, :vehicle_id))
                format.html { redirect_to bg_system_covereds_url,
                              notice: 'BgSystemCovered was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @bg_system_covered.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /bg_system_covereds/1
    # DELETE /bg_system_covereds/1.json
    def destroy
        @bg_system_covered = BgSystemCovered.find(params[:id])
        @bg_system_covered.destroy

        respond_to do |format|
            format.html { redirect_to bg_system_covereds_url }
            format.json { head :no_content }
        end
    end
end
