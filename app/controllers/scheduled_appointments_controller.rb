class ScheduledAppointmentsController < ApplicationController
    # GET /scheduled_appointments
    # GET /scheduled_appointments.json
    def index
        @scheduled_appointments = ScheduledAppointment.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @scheduled_appointments }
        end
    end

    # GET /scheduled_appointments/1
    # GET /scheduled_appointments/1.json
    def show
        @scheduled_appointment = ScheduledAppointment.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @scheduled_appointment }
        end
    end

    # GET /scheduled_appointments/new
    # GET /scheduled_appointments/new.json
    def new
        @scheduled_appointment = ScheduledAppointment.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @scheduled_appointment }
        end
    end

    # GET /scheduled_appointments/1/edit
    def edit
        @scheduled_appointment = ScheduledAppointment.find(params[:id])
    end

    # POST /scheduled_appointments
    # POST /scheduled_appointments.json
    def create
        @scheduled_appointment = ScheduledAppointment.new(params[:scheduled_appointment])

        respond_to do |format|
            if @scheduled_appointment.save
                format.html { redirect_to @scheduled_appointment, notice: 'Scheduled appointment was successfully created.' }
                format.json { render json: @scheduled_appointment, status: :created, location: @scheduled_appointment }
            else
                format.html { render action: "new" }
                format.json { render json: @scheduled_appointment.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /scheduled_appointments/1
    # PUT /scheduled_appointments/1.json
    def update
        @scheduled_appointment = ScheduledAppointment.find(params[:id])

        respond_to do |format|
            if @scheduled_appointment.update_attributes(params[:scheduled_appointment])
                format.html { redirect_to @scheduled_appointment, notice: 'Scheduled appointment was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @scheduled_appointment.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /scheduled_appointments/1
    # DELETE /scheduled_appointments/1.json
    def destroy
        @scheduled_appointment = ScheduledAppointment.find(params[:id])
        @scheduled_appointment.destroy

        respond_to do |format|
            format.html { redirect_to scheduled_appointments_url }
            format.json { head :no_content }
        end
    end
end
