class WheelDrivesController < ApplicationController

    before_action :database_area

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
        @wheel_drive = WheelDrive.new(params.require(:wheel_drive).permit(:name))

        respond_to do |format|
            if @wheel_drive.save
                format.html { redirect_to wheel_drives_url,
                              notice: 'WheelDrive was successfully created.' }
                format.json { render json: @wheel_drive, status: :created, location: @wheel_drive }
            else
                format.html { render action: "new" }
                format.json { render json: @wheel_drive.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /wheel_drives/1
    # PUT /wheel_drives/1.json
    def update
        @wheel_drive = WheelDrive.find(params[:id])

        respond_to do |format|
            if @wheel_drive.update_attributes(params.require(:wheel_drive).permit(:name))
                format.html { redirect_to wheel_drives_url,
                              notice: 'WheelDrive was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @wheel_drive.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /wheel_drives/1
    # DELETE /wheel_drives/1.json
    def destroy
        @wheel_drive = WheelDrive.find(params[:id])
        @wheel_drive.destroy

        respond_to do |format|
            format.html { redirect_to wheel_drives_url }
            format.json { head :no_content }
        end
    end
end
