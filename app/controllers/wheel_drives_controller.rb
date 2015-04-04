class WheelDrivesController < ApplicationController
    # GET /wheel_drives
    # GET /wheel_drives.json
    def index
        @wheel_drives = WheelDrive.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @wheel_drives }
        end
    end

    # GET /wheel_drives/1
    # GET /wheel_drives/1.json
    def show
        @wheel_drife = WheelDrive.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @wheel_drife }
        end
    end

    # GET /wheel_drives/new
    # GET /wheel_drives/new.json
    def new
        @wheel_drife = WheelDrive.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @wheel_drife }
        end
    end

    # GET /wheel_drives/1/edit
    def edit
        @wheel_drife = WheelDrive.find(params[:id])
    end

    # POST /wheel_drives
    # POST /wheel_drives.json
    def create
        @wheel_drife = WheelDrive.new(params[:wheel_drife])

        respond_to do |format|
            if @wheel_drife.save
                format.html { redirect_to @wheel_drife, notice: 'Wheel drive was successfully created.' }
                format.json { render json: @wheel_drife, status: :created, location: @wheel_drife }
            else
                format.html { render action: "new" }
                format.json { render json: @wheel_drife.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /wheel_drives/1
    # PUT /wheel_drives/1.json
    def update
        @wheel_drife = WheelDrive.find(params[:id])

        respond_to do |format|
            if @wheel_drife.update_attributes(params[:wheel_drife])
                format.html { redirect_to @wheel_drife, notice: 'Wheel drive was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @wheel_drife.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /wheel_drives/1
    # DELETE /wheel_drives/1.json
    def destroy
        @wheel_drife = WheelDrive.find(params[:id])
        @wheel_drife.destroy

        respond_to do |format|
            format.html { redirect_to wheel_drives_url }
            format.json { head :no_content }
        end
    end
end
