class NonMaMaintenancesController < ApplicationController
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

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @non_ma_maintenance }
        end
    end

    # GET /non_ma_maintenances/new
    # GET /non_ma_maintenances/new.json
    def new
        @non_ma_maintenance = NonMaMaintenance.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @non_ma_maintenance }
        end
    end

    # GET /non_ma_maintenances/1/edit
    def edit
        @non_ma_maintenance = NonMaMaintenance.find(params[:id])
    end

    # POST /non_ma_maintenances
    # POST /non_ma_maintenances.json
    def create
        @non_ma_maintenance = NonMaMaintenance.new(params[:non_ma_maintenance])

        respond_to do |format|
            if @non_ma_maintenance.save
                format.html { redirect_to @non_ma_maintenance, notice: 'Non ma maintenance was successfully created.' }
                format.json { render json: @non_ma_maintenance, status: :created, location: @non_ma_maintenance }
            else
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
            if @non_ma_maintenance.update_attributes(params[:non_ma_maintenance])
                format.html { redirect_to @non_ma_maintenance, notice: 'Non ma maintenance was successfully updated.' }
                format.json { head :no_content }
            else
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
