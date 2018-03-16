class ReferredBiesController < ApplicationController

    before_action :database_area

    # GET /referred_bies
    # GET /referred_bies.json
    def index
        @referred_bies = ReferredBy.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @referred_bies }
        end
    end

    # GET /referred_bies/1
    # GET /referred_bies/1.json
    def show
        @referred_by = ReferredBy.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @referred_by }
        end
    end

    # GET /referred_bies/new
    # GET /referred_bies/new.json
    def new
        @referred_by = ReferredBy.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @referred_by }
        end
    end

    # GET /referred_bies/1/edit
    def edit
        @referred_by = ReferredBy.find(params[:id])
    end

    # POST /referred_bies
    # POST /referred_bies.json
    def create
        @referred_by = ReferredBy.new( params.require(:referred_by).permit(:description, :is_other))

        respond_to do |format|
            if @referred_by.save
                format.html { redirect_to referred_bies_url,
                              notice: 'ReferredBy was successfully created.' }
                format.json { render json: @referred_by, status: :created, location: @referred_by }
            else
                format.html { render action: "new" }
                format.json { render json: @referred_by.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /referred_bies/1
    # PUT /referred_bies/1.json
    def update
        @referred_by = ReferredBy.find(params[:id])

        respond_to do |format|
            if @referred_by.update_attributes( params.require(:referred_by).permit(:description, :is_other))
                format.html { redirect_to referred_bies_url,
                              notice: 'ReferredBy was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @referred_by.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /referred_bies/1
    # DELETE /referred_bies/1.json
    def destroy
        @referred_by = ReferredBy.find(params[:id])
        @referred_by.destroy

        respond_to do |format|
            format.html { redirect_to referred_bies_url }
            format.json { head :no_content }
        end
    end
end
