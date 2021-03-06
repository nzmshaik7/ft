class BreakdownsController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ] 
        }
    end

    # GET /breakdowns
    # GET /breakdowns.json
    def index
        @breakdowns = Breakdown.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @breakdowns }
        end
    end

    # GET /breakdowns/1
    # GET /breakdowns/1.json
    def show
        @breakdown = Breakdown.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @breakdown }
        end
    end

    # GET /breakdowns/new
    # GET /breakdowns/new.json
    def new
        @breakdown = Breakdown.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @breakdown }
        end
    end

    # GET /breakdowns/1/edit
    def edit
        @breakdown = Breakdown.find(params[:id])
        prepFormVariables
    end

    # POST /breakdowns
    # POST /breakdowns.json
    def create
        @breakdown = Breakdown.new(params.require(:breakdown).permit(:bdate, :description, :vehicle_id))

        respond_to do |format|
            if @breakdown.save
                format.html { redirect_to breakdowns_url,
                              notice: 'Breakdown was successfully created.' }
                format.json { render json: @breakdown, status: :created, location: @breakdown }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @breakdown.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /breakdowns/1
    # PUT /breakdowns/1.json
    def update
        @breakdown = Breakdown.find(params[:id])

        respond_to do |format|
            if @breakdown.update_attributes(params.require(:breakdown).permit(:bdate, :description, :vehicle_id))
                format.html { redirect_to breakdowns_url,
                              notice: 'Breakdown was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @breakdown.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /breakdowns/1
    # DELETE /breakdowns/1.json
    def destroy
        @breakdown = Breakdown.find(params[:id])
        @breakdown.destroy

        respond_to do |format|
            format.html { redirect_to breakdowns_url }
            format.json { head :no_content }
        end
    end
end
