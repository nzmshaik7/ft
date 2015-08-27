class PartManufacturersController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit, ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, ]
    include ApplicationHelper

    # GET /part_manufacturers
    # GET /part_manufacturers.json
    def index
        @part_manufacturers = PartManufacturer.find(:all, :order => 'name')

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @part_manufacturers }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /part_manufacturers/1
    # GET /part_manufacturers/1.json
    def show
        @part_manufacturer = PartManufacturer.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @part_manufacturer }
        end
    end


    # GET /part_manufacturers/new
    # GET /part_manufacturers/new.json
    def new
        @part_manufacturer = PartManufacturer.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @part_manufacturer }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /part_manufacturers/1/edit
    def edit
        @part_manufacturer = PartManufacturer.find(params[:id])
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validatePartManufacturer?(pm)
        ok = true
        pm.name.strip!  if pm.name
        if pm.name.nil? or pm.name == ''
            ok = false
            addSessionError('Part Manufacturer Name is required field.')
        end

        return ok
    end


    # POST /part_manufacturers
    # POST /part_manufacturers.json
    def create
        @part_manufacturer = PartManufacturer.new(params[:part_manufacturer])
        ok = validatePartManufacturer?(@part_manufacturer)
        okUrl, errAction = setSaveAction('new', part_manufacturers_url)

        respond_to do |format|
            if ok and @part_manufacturer.save
                format.html { redirect_to okUrl,
                          notice: 'PartManufacturer was successfully created.' }
                format.json { render json: @part_manufacturer,
                                     status: :created,
                                     location: @part_manufacturer }
            else
                format.html { render action: errAction }
                format.json { render json: @part_manufacturer.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /part_manufacturers/1
    # PUT /part_manufacturers/1.json
    def update
        @part_manufacturer = PartManufacturer.find(params[:id])

        respond_to do |format|
            @part_manufacturer.assign_attributes(params[:part_manufacturer])
            parok = validatePartManufacturer?(@part_manufacturer)
            okUrl, errAction = setSaveAction('edit', part_manufacturers_url)
            saveok = false
            if parok
                saveok = @part_manufacturer.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                          notice: 'PartManufacturer was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: errAction }
                format.json { render json: @part_manufacturer.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /part_manufacturers/1
    # DELETE /part_manufacturers/1.json
    def destroy
        @part_manufacturer = PartManufacturer.find(params[:id])
        @part_manufacturer.destroy

        respond_to do |format|
            format.html { redirect_to part_manufacturers_url }
            format.json { head :no_content }
        end
    end
end
