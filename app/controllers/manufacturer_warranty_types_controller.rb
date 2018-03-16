class ManufacturerWarrantyTypesController < ApplicationController
    # GET /manufacturer_warranty_types
    # GET /manufacturer_warranty_types.json
    def index
        @manufacturer_warranty_types = ManufacturerWarrantyType.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @manufacturer_warranty_types }
        end
    end

    # GET /manufacturer_warranty_types/1
    # GET /manufacturer_warranty_types/1.json
    def show
        @manufacturer_warranty_type = ManufacturerWarrantyType.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @manufacturer_warranty_type }
        end
    end

    # GET /manufacturer_warranty_types/new
    # GET /manufacturer_warranty_types/new.json
    def new
        @manufacturer_warranty_type = ManufacturerWarrantyType.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @manufacturer_warranty_type }
        end
    end

    # GET /manufacturer_warranty_types/1/edit
    def edit
        @manufacturer_warranty_type = ManufacturerWarrantyType.find(params[:id])
    end

    # POST /manufacturer_warranty_types
    # POST /manufacturer_warranty_types.json
    def create
        @manufacturer_warranty_type = ManufacturerWarrantyType.new(params.require(:manufacturer_warranty_type).permit(:name))

        respond_to do |format|
            if @manufacturer_warranty_type.save
                format.html { redirect_to manufacturer_warranty_types_url,
                              notice: 'Manufacturer warranty type was successfully created.' }
                format.json { render json: @manufacturer_warranty_type, status: :created, location: @manufacturer_warranty_type }
            else
                format.html { render action: "new" }
                format.json { render json: @manufacturer_warranty_type.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /manufacturer_warranty_types/1
    # PUT /manufacturer_warranty_types/1.json
    def update
        @manufacturer_warranty_type = ManufacturerWarrantyType.find(params[:id])

        respond_to do |format|
            if @manufacturer_warranty_type.update_attributes(params.require(:manufacturer_warranty_type).permit(:name))
                format.html { redirect_to manufacturer_warranty_types_url,
                              notice: 'Manufacturer warranty type was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @manufacturer_warranty_type.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /manufacturer_warranty_types/1
    # DELETE /manufacturer_warranty_types/1.json
    def destroy
        @manufacturer_warranty_type = ManufacturerWarrantyType.find(params[:id])
        @manufacturer_warranty_type.destroy

        respond_to do |format|
            format.html { redirect_to manufacturer_warranty_types_url }
            format.json { head :no_content }
        end
    end
end
