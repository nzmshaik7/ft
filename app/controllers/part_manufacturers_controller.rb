class PartManufacturersController < ApplicationController

    before_filter :only_allow_admins

    # GET /part_manufacturers
    # GET /part_manufacturers.json
    def index
        @part_manufacturers = PartManufacturer.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @part_manufacturers }
        end
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

    # GET /part_manufacturers/1/edit
    def edit
        @part_manufacturer = PartManufacturer.find(params[:id])
    end

    # POST /part_manufacturers
    # POST /part_manufacturers.json
    def create
        @part_manufacturer = PartManufacturer.new(params[:part_manufacturer])

        respond_to do |format|
            if @part_manufacturer.save
                format.html { redirect_to part_manufacturers_url,
                              notice: 'PartManufacturer was successfully created.' }
                format.json { render json: @part_manufacturer, status: :created, location: @part_manufacturer }
            else
                format.html { render action: "new" }
                format.json { render json: @part_manufacturer.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /part_manufacturers/1
    # PUT /part_manufacturers/1.json
    def update
        @part_manufacturer = PartManufacturer.find(params[:id])

        respond_to do |format|
            if @part_manufacturer.update_attributes(params[:part_manufacturer])
                format.html { redirect_to part_manufacturers_url,
                              notice: 'PartManufacturer was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @part_manufacturer.errors, status: :unprocessable_entity }
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
