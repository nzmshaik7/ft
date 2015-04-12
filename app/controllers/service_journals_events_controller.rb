class ServiceJournalsEventsController < ApplicationController

    before_filter :only_allow_admins

    # GET /service_journals_events
    # GET /service_journals_events.json
    def index
        @service_journals_events = ServiceJournalsEvent.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_journals_events }
        end
    end

    # GET /service_journals_events/1
    # GET /service_journals_events/1.json
    def show
        @service_journals_event = ServiceJournalsEvent.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_journals_event }
        end
    end

    # GET /service_journals_events/new
    # GET /service_journals_events/new.json
    def new
        @service_journals_event = ServiceJournalsEvent.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_journals_event }
        end
    end

    # GET /service_journals_events/1/edit
    def edit
        @service_journals_event = ServiceJournalsEvent.find(params[:id])
    end

    # POST /service_journals_events
    # POST /service_journals_events.json
    def create
        @service_journals_event = ServiceJournalsEvent.new(params[:service_journals_event])

        respond_to do |format|
            if @service_journals_event.save
                format.html { redirect_to service_journals_events_url,
                              notice: 'ServiceJournalsEvent was successfully created.' }
                format.json { render json: @service_journals_event, status: :created, location: @service_journals_event }
            else
                format.html { render action: "new" }
                format.json { render json: @service_journals_event.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_journals_events/1
    # PUT /service_journals_events/1.json
    def update
        @service_journals_event = ServiceJournalsEvent.find(params[:id])

        respond_to do |format|
            if @service_journals_event.update_attributes(params[:service_journals_event])
                format.html { redirect_to service_journals_events_url,
                              notice: 'ServiceJournalsEvent was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @service_journals_event.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_journals_events/1
    # DELETE /service_journals_events/1.json
    def destroy
        @service_journals_event = ServiceJournalsEvent.find(params[:id])
        @service_journals_event.destroy

        respond_to do |format|
            format.html { redirect_to service_journals_events_url }
            format.json { head :no_content }
        end
    end
end
