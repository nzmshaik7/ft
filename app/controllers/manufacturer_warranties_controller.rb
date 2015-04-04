class ManufacturerWarrantiesController < ApplicationController

    before_filter :only_allow_admins

    # GET /manufacturer_warranties
    # GET /manufacturer_warranties.json
    def index
        @manufacturer_warranties = ManufacturerWarranty.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @manufacturer_warranties }
        end
    end

    # GET /manufacturer_warranties/1
    # GET /manufacturer_warranties/1.json
    def show
        @manufacturer_warranty = ManufacturerWarranty.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @manufacturer_warranty }
        end
    end

    # GET /manufacturer_warranties/new
    # GET /manufacturer_warranties/new.json
    def new
        @manufacturer_warranty = ManufacturerWarranty.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @manufacturer_warranty }
        end
    end

    # GET /manufacturer_warranties/1/edit
    def edit
        @manufacturer_warranty = ManufacturerWarranty.find(params[:id])
    end

    # POST /manufacturer_warranties
    # POST /manufacturer_warranties.json
    def create
        @manufacturer_warranty = ManufacturerWarranty.new(params[:manufacturer_warranty])

        respond_to do |format|
            if @manufacturer_warranty.save
                format.html { redirect_to manufacturerwarranties_url,
                              notice: 'ManufacturerWarranty was successfully created.' }
                format.json { render json: @manufacturer_warranty, status: :created, location: @manufacturer_warranty }
            else
                format.html { render action: "new" }
                format.json { render json: @manufacturer_warranty.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /manufacturer_warranties/1
    # PUT /manufacturer_warranties/1.json
    def update
        @manufacturer_warranty = ManufacturerWarranty.find(params[:id])

        respond_to do |format|
            if @manufacturer_warranty.update_attributes(params[:manufacturer_warranty])
                format.html { redirect_to manufacturerwarranties_url,
                              notice: 'ManufacturerWarranty was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @manufacturer_warranty.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /manufacturer_warranties/1
    # DELETE /manufacturer_warranties/1.json
    def destroy
        @manufacturer_warranty = ManufacturerWarranty.find(params[:id])
        @manufacturer_warranty.destroy

        respond_to do |format|
            format.html { redirect_to manufacturer_warranties_url }
            format.json { head :no_content }
        end
    end
end
