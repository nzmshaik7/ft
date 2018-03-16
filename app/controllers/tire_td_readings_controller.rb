class TireTdReadingsController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ] 
        }
    end

    # GET /tire_td_readings
    # GET /tire_td_readings.json
    def index
        @tire_td_readings = TireTdReading.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @tire_td_readings }
        end
    end

    # GET /tire_td_readings/1
    # GET /tire_td_readings/1.json
    def show
        @tire_td_reading = TireTdReading.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @tire_td_reading }
        end
    end

    # GET /tire_td_readings/new
    # GET /tire_td_readings/new.json
    def new
        @tire_td_reading = TireTdReading.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @tire_td_reading }
        end
    end

    # GET /tire_td_readings/1/edit
    def edit
        @tire_td_reading = TireTdReading.find(params[:id])
        prepFormVariables
    end

    # POST /tire_td_readings
    # POST /tire_td_readings.json
    def create
        @tire_td_reading = TireTdReading.new(params.require(:tire_td_reading).permit(:depth32nds, :tdate, :vehicle_id))

        respond_to do |format|
            if @tire_td_reading.save
                format.html { redirect_to tire_td_readings_url,
                              notice: 'TireTdReading was successfully created.' }
                format.json { render json: @tire_td_reading, status: :created, location: @tire_td_reading }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @tire_td_reading.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /tire_td_readings/1
    # PUT /tire_td_readings/1.json
    def update
        @tire_td_reading = TireTdReading.find(params[:id])

        respond_to do |format|
            if @tire_td_reading.update_attributes(params.require(:tire_td_reading).permit(:depth32nds, :tdate, :vehicle_id))
                format.html { redirect_to tire_td_readings_url,
                              notice: 'TireTdReading was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @tire_td_reading.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /tire_td_readings/1
    # DELETE /tire_td_readings/1.json
    def destroy
        @tire_td_reading = TireTdReading.find(params[:id])
        @tire_td_reading.destroy

        respond_to do |format|
            format.html { redirect_to tire_td_readings_url }
            format.json { head :no_content }
        end
    end
end
