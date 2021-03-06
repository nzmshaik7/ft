class CountiesController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @states = State.all
        @stateCollect = @states.collect { |p|
            [ p.name, p.id ] 
        }
    end

    # GET /counties
    # GET /counties.json
    def index
        @counties = County.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @counties }
        end
    end

    # GET /counties/1
    # GET /counties/1.json
    def show
        @county = County.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @county }
        end
    end

    # GET /counties/new
    # GET /counties/new.json
    def new
        @county = County.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @county }
        end
    end

    # GET /counties/1/edit
    def edit
        @county = County.find(params[:id])
        prepFormVariables
    end

    # POST /counties
    # POST /counties.json
    def create
        @county = County.new(params.require(:county).permit(:name, :state_id))

        respond_to do |format|
            if @county.save
                format.html { redirect_to counties_url,
                              notice: 'County was successfully created.' }
                format.json { render json: @county, status: :created, location: @county }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @county.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /counties/1
    # PUT /counties/1.json
    def update
        @county = County.find(params[:id])

        respond_to do |format|
            if @county.update_attributes(params.require(:county).permit(:name, :state_id))
                format.html { redirect_to counties_url,
                              notice: 'County was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @county.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /counties/1
    # DELETE /counties/1.json
    def destroy
        @county = County.find(params[:id])
        @county.destroy

        respond_to do |format|
            format.html { redirect_to counties_url }
            format.json { head :no_content }
        end
    end
end
