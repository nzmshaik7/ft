class CylinderCompressionsController < ApplicationController
    # GET /cylinder_compressions
    # GET /cylinder_compressions.json
    def index
        @cylinder_compressions = CylinderCompression.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @cylinder_compressions }
        end
    end

    # GET /cylinder_compressions/1
    # GET /cylinder_compressions/1.json
    def show
        @cylinder_compression = CylinderCompression.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @cylinder_compression }
        end
    end

    # GET /cylinder_compressions/new
    # GET /cylinder_compressions/new.json
    def new
        @cylinder_compression = CylinderCompression.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @cylinder_compression }
        end
    end

    # GET /cylinder_compressions/1/edit
    def edit
        @cylinder_compression = CylinderCompression.find(params[:id])
    end

    # POST /cylinder_compressions
    # POST /cylinder_compressions.json
    def create
        @cylinder_compression = CylinderCompression.new(params[:cylinder_compression])

        respond_to do |format|
            if @cylinder_compression.save
                format.html { redirect_to cylindercompressions_url,
                              notice: 'CylinderCompression was successfully created.' }
                format.json { render json: @cylinder_compression, status: :created, location: @cylinder_compression }
            else
                format.html { render action: "new" }
                format.json { render json: @cylinder_compression.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /cylinder_compressions/1
    # PUT /cylinder_compressions/1.json
    def update
        @cylinder_compression = CylinderCompression.find(params[:id])

        respond_to do |format|
            if @cylinder_compression.update_attributes(params[:cylinder_compression])
                format.html { redirect_to cylindercompressions_url,
                              notice: 'CylinderCompression was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @cylinder_compression.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /cylinder_compressions/1
    # DELETE /cylinder_compressions/1.json
    def destroy
        @cylinder_compression = CylinderCompression.find(params[:id])
        @cylinder_compression.destroy

        respond_to do |format|
            format.html { redirect_to cylinder_compressions_url }
            format.json { head :no_content }
        end
    end
end
