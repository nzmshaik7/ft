class ServiceSchedulesController < ApplicationController

    before_filter :only_allow_admins

    # GET /service_schedules
    # GET /service_schedules.json
    def index
        @service_schedules = ServiceSchedule.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_schedules }
        end
    end

    # GET /service_schedules/1
    # GET /service_schedules/1.json
    def show
        @service_schedule = ServiceSchedule.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_schedule }
        end
    end

    # GET /service_schedules/new
    # GET /service_schedules/new.json
    def new
        @service_schedule = ServiceSchedule.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_schedule }
        end
    end

    # GET /service_schedules/1/edit
    def edit
        @service_schedule = ServiceSchedule.find(params[:id])
    end

    # POST /service_schedules
    # POST /service_schedules.json
    def create
        @service_schedule = ServiceSchedule.new(params[:service_schedule])

        respond_to do |format|
            if @service_schedule.save
                format.html { redirect_to serviceschedules_url,
                              notice: 'ServiceSchedule was successfully created.' }
                format.json { render json: @service_schedule, status: :created, location: @service_schedule }
            else
                format.html { render action: "new" }
                format.json { render json: @service_schedule.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_schedules/1
    # PUT /service_schedules/1.json
    def update
        @service_schedule = ServiceSchedule.find(params[:id])

        respond_to do |format|
            if @service_schedule.update_attributes(params[:service_schedule])
                format.html { redirect_to serviceschedules_url,
                              notice: 'ServiceSchedule was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @service_schedule.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_schedules/1
    # DELETE /service_schedules/1.json
    def destroy
        @service_schedule = ServiceSchedule.find(params[:id])
        @service_schedule.destroy

        respond_to do |format|
            format.html { redirect_to service_schedules_url }
            format.json { head :no_content }
        end
    end
end
