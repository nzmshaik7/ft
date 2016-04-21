class ServiceVisitNotesController < ApplicationController

    before_filter :database_area

    # GET /service_visit_notes
    # GET /service_visit_notes.json
    def index
        @service_visit_notes = ServiceVisitNote.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_visit_notes }
        end
    end

    # GET /service_visit_notes/1
    # GET /service_visit_notes/1.json
    def show
        @service_visit_note = ServiceVisitNote.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_visit_note }
        end
    end

    # GET /service_visit_notes/new
    # GET /service_visit_notes/new.json
    def new
        @service_visit_note = ServiceVisitNote.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_visit_note }
        end
    end

    # GET /service_visit_notes/1/edit
    def edit
        @service_visit_note = ServiceVisitNote.find(params[:id])
    end

    # POST /service_visit_notes
    # POST /service_visit_notes.json
    def create
        @service_visit_note = ServiceVisitNote.new(params[:service_visit_note])

        respond_to do |format|
            if @service_visit_note.save
                format.html { redirect_to service_visit_notes_url, notice: 'Service visit note was successfully created.' }
                format.json { render json: @service_visit_note, status: :created, location: @service_visit_note }
            else
                format.html { render action: "new" }
                format.json { render json: @service_visit_note.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_visit_notes/1
    # PUT /service_visit_notes/1.json
    def update
        @service_visit_note = ServiceVisitNote.find(params[:id])

        respond_to do |format|
            if @service_visit_note.update_attributes(params[:service_visit_note])
                format.html { redirect_to service_visit_notes_url, notice: 'Service visit note was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @service_visit_note.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_visit_notes/1
    # DELETE /service_visit_notes/1.json
    def destroy
        @service_visit_note = ServiceVisitNote.find(params[:id])
        @service_visit_note.destroy

        respond_to do |format|
            format.html { redirect_to service_visit_notes_url }
            format.json { head :no_content }
        end
    end
end
