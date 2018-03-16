class BackupsController < ApplicationController

    before_action :database_area

    # GET /backups
    # GET /backups.json
    def index
        @backups = Backup.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @backups }
        end
    end

    # GET /backups/1
    # GET /backups/1.json
    def show
        @backup = Backup.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @backup }
        end
    end

    # GET /backups/new
    # GET /backups/new.json
    def new
        @backup = Backup.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @backup }
        end
    end

    # GET /backups/1/edit
    def edit
        @backup = Backup.find(params[:id])
    end

    # POST /backups
    # POST /backups.json
    def create
        @backup = Backup.new(params.require(:backup).permit(:info, :table_name, :user_id))

        respond_to do |format|
            if @backup.save
                format.html { redirect_to backups_url, notice: 'Backup was successfully created.' }
                format.json { render json: @backup, status: :created, location: @backup }
            else
                format.html { render action: "new" }
                format.json { render json: @backup.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /backups/1
    # PUT /backups/1.json
    def update
        @backup = Backup.find(params[:id])

        respond_to do |format|
            if @backup.update_attributes(params.require(:backup).permit(:info, :table_name, :user_id))
                format.html { redirect_to backups_url, notice: 'Backup was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @backup.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /backups/1
    # DELETE /backups/1.json
    def destroy
        @backup = Backup.find(params[:id])
        @backup.destroy

        respond_to do |format|
            format.html { redirect_to backups_url }
            format.json { head :no_content }
        end
    end
end
