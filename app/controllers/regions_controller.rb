class RegionsController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @states = State.all
        @stateCollect = @states.collect { |p|
            [ p.name, p.id ] 
        }
    end

    # GET /regions
    # GET /regions.json
    def index
        @regions = Region.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @regions }
        end
    end

    # GET /regions/1
    # GET /regions/1.json
    def show
        @region = Region.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @region }
        end
    end

    # GET /regions/new
    # GET /regions/new.json
    def new
        @region = Region.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @region }
        end
    end

    # GET /regions/1/edit
    def edit
        @region = Region.find(params[:id])
        prepFormVariables
    end

    # POST /regions
    # POST /regions.json
    def create
        @region = Region.new(params.require(:region).permit(:name, :state_id)
)

        respond_to do |format|
            if @region.save
                format.html { redirect_to regions_url,
                              notice: 'Region was successfully created.' }
                format.json { render json: @region, status: :created, location: @region }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @region.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /regions/1
    # PUT /regions/1.json
    def update
        @region = Region.find(params[:id])

        respond_to do |format|
            if @region.update_attributes(params.require(:region).permit(:name, :state_id)
)
                format.html { redirect_to regions_url,
                              notice: 'Region was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @region.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /regions/1
    # DELETE /regions/1.json
    def destroy
        @region = Region.find(params[:id])
        @region.destroy

        respond_to do |format|
            format.html { redirect_to regions_url }
            format.json { head :no_content }
        end
    end
end
