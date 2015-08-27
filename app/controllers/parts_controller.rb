class PartsController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit, ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, ]
    include ApplicationHelper

    def prepFormVariables
        @part_manufacturers = PartManufacturer.find(:all, :order => 'name')
        @part_manufacturerCollect = @part_manufacturers.collect { |p|
            [ p.name, p.id ]
        }
        @part_names = PartName.find(:all, :order => 'name')
        @part_nameCollect = @part_names.collect { |p|
            [ p.name, p.id ]
        }
    end


    # GET /parts
    # GET /parts.json
    def index
        @parts = Part.find(:all, :order => 'part_number')

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @parts }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /parts/1
    # GET /parts/1.json
    def show
        @part = Part.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @part }
        end
    end


    # GET /parts/new
    # GET /parts/new.json
    def new
        @part = Part.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @part }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /parts/1/edit
    def edit
        @part = Part.find(params[:id])
        prepFormVariables
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validatePart?(part)
        ok = true

        if part.part_manufacturer.nil?
            ok = false
            addSessionError('You must select a Part Manufacturer.')
        end
        if part.part_name.nil?
            ok = false
            addSessionError('You must select a (generic) Part Name.')
        end

        part.description.strip!  if part.description
        part.part_number.strip!  if part.part_number
        if part.part_number.nil? or part.part_number == ''
            ok = false
            addSessionError('Part number is required field.')
        end

        return ok
    end


    # POST /parts
    # POST /parts.json
    def create
        @part = Part.new(params[:part])
        ok = validatePart?(@part)
        okUrl, errAction = setSaveAction('new', parts_url)

        respond_to do |format|
            if ok and @part.save
                format.html { redirect_to okUrl,
                              notice: 'Part was successfully created.' }
                format.json { render json: @part, status: :created,
                                     location: @part }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @part.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /parts/1
    # PUT /parts/1.json
    def update
        @part = Part.find(params[:id])

        respond_to do |format|
            @part.assign_attributes(params[:part])
            parok = validatePart?(@part)
            okUrl, errAction = setSaveAction('edit', parts_url)
            saveok = false
            if parok
                saveok = @part.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                              notice: 'Part was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @part.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /parts/1
    # DELETE /parts/1.json
    def destroy
        @part = Part.find(params[:id])
        @part.destroy

        respond_to do |format|
            format.html { redirect_to parts_url }
            format.json { head :no_content }
        end
    end

end
