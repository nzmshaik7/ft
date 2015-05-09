class WrittenTestimoniesController < ApplicationController

    before_filter :only_allow_admins

    # GET /written_testimonies
    # GET /written_testimonies.json
    def index
        @written_testimonies = WrittenTestimony.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @written_testimonies }
        end
    end

    # GET /written_testimonies/1
    # GET /written_testimonies/1.json
    def show
        @written_testimony = WrittenTestimony.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @written_testimony }
        end
    end

    # Comes from analytics page
    def showana
        @written_testimony = WrittenTestimony.find(params[:id])
    end

    # GET /written_testimonies/new
    # GET /written_testimonies/new.json
    def new
        @written_testimony = WrittenTestimony.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @written_testimony }
        end
    end

    # GET /written_testimonies/1/edit
    def edit
        @written_testimony = WrittenTestimony.find(params[:id])
    end

    # POST /written_testimonies
    # POST /written_testimonies.json
    def create
        @written_testimony = WrittenTestimony.new(params[:written_testimony])

        respond_to do |format|
            if @written_testimony.save
                format.html { redirect_to written_testimonies_url,
                              notice: 'WrittenTestimony was successfully created.' }
                format.json { render json: @written_testimony, status: :created, location: @written_testimony }
            else
                format.html { render action: "new" }
                format.json { render json: @written_testimony.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /written_testimonies/1
    # PUT /written_testimonies/1.json
    def update
        @written_testimony = WrittenTestimony.find(params[:id])

        respond_to do |format|
            if @written_testimony.update_attributes(params[:written_testimony])
                format.html { redirect_to written_testimonies_url,
                              notice: 'WrittenTestimony was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @written_testimony.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /written_testimonies/1
    # DELETE /written_testimonies/1.json
    def destroy
        @written_testimony = WrittenTestimony.find(params[:id])
        @written_testimony.destroy

        respond_to do |format|
            format.html { redirect_to written_testimonies_url }
            format.json { head :no_content }
        end
    end
end
