class NonMaMaintenancesController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ]
        }
    end

    # GET /non_ma_maintenances
    # GET /non_ma_maintenances.json
    def index
        @non_ma_maintenances = NonMaMaintenance.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @non_ma_maintenances }
        end
    end

    # GET /non_ma_maintenances/1
    # GET /non_ma_maintenances/1.json
    def show
        @non_ma_maintenance = NonMaMaintenance.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @non_ma_maintenance }
        end
    end

    # GET /non_ma_maintenances/new
    # GET /non_ma_maintenances/new.json
    def new
        @non_ma_maintenance = NonMaMaintenance.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @non_ma_maintenance }
        end
    end

    # GET /non_ma_maintenances/1/edit
    def edit
        @non_ma_maintenance = NonMaMaintenance.find(params[:id])
        prepFormVariables
    end

    # POST /non_ma_maintenances
    # POST /non_ma_maintenances.json
    def create
        @non_ma_maintenance = NonMaMaintenance.new(params.require(:non_ma_maintenance).permit(:document_image_id, :mdate, :vehicle_id, :where))

        respond_to do |format|
            if @non_ma_maintenance.save
                format.html { redirect_to non_ma_maintenances_url,
                              notice: 'NonMaMaintenance was successfully created.' }
                format.json { render json: @non_ma_maintenance, status: :created, location: @non_ma_maintenance }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @non_ma_maintenance.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /non_ma_maintenances/1
    # PUT /non_ma_maintenances/1.json
    def update
        @non_ma_maintenance = NonMaMaintenance.find(params[:id])

        respond_to do |format|
            if @non_ma_maintenance.update_attributes(params.require(:non_ma_maintenance).permit(:document_image_id, :mdate, :vehicle_id, :where))
                format.html { redirect_to non_ma_maintenances_url,
                              notice: 'NonMaMaintenance was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @non_ma_maintenance.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /non_ma_maintenances/1
    # DELETE /non_ma_maintenances/1.json
    def destroy
        @non_ma_maintenance = NonMaMaintenance.find(params[:id])
        @non_ma_maintenance.destroy

        respond_to do |format|
            format.html { redirect_to non_ma_maintenances_url }
            format.json { head :no_content }
        end
    end
end
