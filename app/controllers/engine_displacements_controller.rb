class EngineDisplacementsController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit, ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, ]
    include ApplicationHelper


    # GET /engine_displacements
    # GET /engine_displacements.json
    def index
        @engine_displacements = EngineDisplacement.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @engine_displacements }
        end
    end


    # GET /engine_displacements/1
    # GET /engine_displacements/1.json
    def show
        @engine_displacement = EngineDisplacement.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @engine_displacement }
        end
    end


    # GET /engine_displacements/new
    # GET /engine_displacements/new.json
    def new
        @engine_displacement = EngineDisplacement.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @engine_displacement }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /engine_displacements/1/edit
    def edit
        @engine_displacement = EngineDisplacement.find(params[:id])
    end


    def validateEngineDisplacement?(edisp)
        ok = true
        edisp.name.strip!  if edisp.name
        if edisp.name.nil? or edisp.name == ''
            ok = false
            addSessionError('Name is required field.')
        end
        return ok
    end


    # POST /engine_displacements
    # POST /engine_displacements.json
    def create
        @engine_displacement = 
                           EngineDisplacement.new(params[:engine_displacement])
        ok = validateEngineDisplacement?(@engine_displacement)
        okUrl, errAction = setSaveAction('new', engine_displacements_url)

        respond_to do |format|
            if ok and @engine_displacement.save
                format.html { redirect_to okUrl,
                      notice: 'Engine Displacement was successfully created.' }
                format.json { render json: @engine_displacement,
                                     status: :created,
                                     location: @engine_displacement }
            else
                format.html { render action: errAction }
                format.json { render json: @engine_displacement.errors,
                                     status: :unprocessable_entity }
            end
        end
    end



    # PUT /engine_displacements/1
    # PUT /engine_displacements/1.json
    def update
        @engine_displacement = EngineDisplacement.find(params[:id])

        respond_to do |format|
            if @engine_displacement.update_attributes(
                                                 params[:engine_displacement])
                format.html { redirect_to engine_displacements_url,
                      notice: 'Engine Displacement was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @engine_displacement.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /engine_displacements/1
    # DELETE /engine_displacements/1.json
    def destroy
        @engine_displacement = EngineDisplacement.find(params[:id])
        @engine_displacement.destroy

        respond_to do |format|
            format.html { redirect_to engine_displacements_url }
            format.json { head :no_content }
        end
    end
end
