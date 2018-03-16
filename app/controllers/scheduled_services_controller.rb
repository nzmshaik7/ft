class ScheduledServicesController < ApplicationController

    before_action :database_area

    # GET /scheduled_services
    # GET /scheduled_services.json
    def index
        @scheduled_services = ScheduledService.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @scheduled_services }
        end
    end

    # GET /scheduled_services/1
    # GET /scheduled_services/1.json
    def show
        @scheduled_service = ScheduledService.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @scheduled_service }
        end
    end

    # GET /scheduled_services/new
    # GET /scheduled_services/new.json
    def new
        @scheduled_service = ScheduledService.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @scheduled_service }
        end
    end

    # GET /scheduled_services/1/edit
    def edit
        @scheduled_service = ScheduledService.find(params[:id])
    end

    # POST /scheduled_services
    # POST /scheduled_services.json
    def create
        @scheduled_service = ScheduledService.new(params.require(:scheduled_service).permit(:mileage, :sdate, :service_schedule_id))

        respond_to do |format|
            if @scheduled_service.save
                format.html { redirect_to scheduled_services_url,
                              notice: 'ScheduledService was successfully created.' }
                format.json { render json: @scheduled_service, status: :created, location: @scheduled_service }
            else
                format.html { render action: "new" }
                format.json { render json: @scheduled_service.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /scheduled_services/1
    # PUT /scheduled_services/1.json
    def update
        @scheduled_service = ScheduledService.find(params[:id])

        respond_to do |format|
            if @scheduled_service.update_attributes(params.require(:scheduled_service).permit(:mileage, :sdate, :service_schedule_id))
                format.html { redirect_to scheduled_services_url,
                              notice: 'ScheduledService was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @scheduled_service.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /scheduled_services/1
    # DELETE /scheduled_services/1.json
    def destroy
        @scheduled_service = ScheduledService.find(params[:id])
        @scheduled_service.destroy

        respond_to do |format|
            format.html { redirect_to scheduled_services_url }
            format.json { head :no_content }
        end
    end
end
