class ServiceJournalsController < ApplicationController
    # GET /service_journals
    # GET /service_journals.json
    def index
        @service_journals = ServiceJournal.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_journals }
        end
    end

    # GET /service_journals/1
    # GET /service_journals/1.json
    def show
        @service_journal = ServiceJournal.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_journal }
        end
    end

    # GET /service_journals/new
    # GET /service_journals/new.json
    def new
        @service_journal = ServiceJournal.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_journal }
        end
    end

    # GET /service_journals/1/edit
    def edit
        @service_journal = ServiceJournal.find(params[:id])
    end

    # POST /service_journals
    # POST /service_journals.json
    def create
        @service_journal = ServiceJournal.new(params[:service_journal])

        respond_to do |format|
            if @service_journal.save
                format.html { redirect_to @service_journal, notice: 'Service journal was successfully created.' }
                format.json { render json: @service_journal, status: :created, location: @service_journal }
            else
                format.html { render action: "new" }
                format.json { render json: @service_journal.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_journals/1
    # PUT /service_journals/1.json
    def update
        @service_journal = ServiceJournal.find(params[:id])

        respond_to do |format|
            if @service_journal.update_attributes(params[:service_journal])
                format.html { redirect_to @service_journal, notice: 'Service journal was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @service_journal.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_journals/1
    # DELETE /service_journals/1.json
    def destroy
        @service_journal = ServiceJournal.find(params[:id])
        @service_journal.destroy

        respond_to do |format|
            format.html { redirect_to service_journals_url }
            format.json { head :no_content }
        end
    end
end
