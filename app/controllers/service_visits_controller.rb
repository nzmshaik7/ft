class ServiceVisitsController < ApplicationController
    # GET /service_visits
    # GET /service_visits.json
    def index
        @service_visits = ServiceVisit.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_visits }
        end
    end

    # GET /service_visits/1
    # GET /service_visits/1.json
    def show
        @service_visit = ServiceVisit.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_visit }
        end
    end

    # GET /service_visits/new
    # GET /service_visits/new.json
    def new
        @service_visit = ServiceVisit.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_visit }
        end
    end

    # GET /service_visits/1/edit
    def edit
        @service_visit = ServiceVisit.find(params[:id])
    end

    # POST /service_visits
    # POST /service_visits.json
    def create
        @service_visit = ServiceVisit.new(params[:service_visit])

        respond_to do |format|
            if @service_visit.save
                format.html { redirect_to @service_visit, notice: 'Service visit was successfully created.' }
                format.json { render json: @service_visit, status: :created, location: @service_visit }
            else
                format.html { render action: "new" }
                format.json { render json: @service_visit.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_visits/1
    # PUT /service_visits/1.json
    def update
        @service_visit = ServiceVisit.find(params[:id])

        respond_to do |format|
            if @service_visit.update_attributes(params[:service_visit])
                format.html { redirect_to @service_visit, notice: 'Service visit was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @service_visit.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_visits/1
    # DELETE /service_visits/1.json
    def destroy
        @service_visit = ServiceVisit.find(params[:id])
        @service_visit.destroy

        respond_to do |format|
            format.html { redirect_to service_visits_url }
            format.json { head :no_content }
        end
    end
end
