class GasMileagesController < ApplicationController
    # GET /gas_mileages
    # GET /gas_mileages.json
    def index
        @gas_mileages = GasMileage.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @gas_mileages }
        end
    end

    # GET /gas_mileages/1
    # GET /gas_mileages/1.json
    def show
        @gas_mileage = GasMileage.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @gas_mileage }
        end
    end

    # GET /gas_mileages/new
    # GET /gas_mileages/new.json
    def new
        @gas_mileage = GasMileage.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @gas_mileage }
        end
    end

    # GET /gas_mileages/1/edit
    def edit
        @gas_mileage = GasMileage.find(params[:id])
    end

    # POST /gas_mileages
    # POST /gas_mileages.json
    def create
        @gas_mileage = GasMileage.new(params[:gas_mileage])

        respond_to do |format|
            if @gas_mileage.save
                format.html { redirect_to gasmileages_url,
                              notice: 'GasMileage was successfully created.' }
                format.json { render json: @gas_mileage, status: :created, location: @gas_mileage }
            else
                format.html { render action: "new" }
                format.json { render json: @gas_mileage.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /gas_mileages/1
    # PUT /gas_mileages/1.json
    def update
        @gas_mileage = GasMileage.find(params[:id])

        respond_to do |format|
            if @gas_mileage.update_attributes(params[:gas_mileage])
                format.html { redirect_to gasmileages_url,
                              notice: 'GasMileage was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @gas_mileage.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /gas_mileages/1
    # DELETE /gas_mileages/1.json
    def destroy
        @gas_mileage = GasMileage.find(params[:id])
        @gas_mileage.destroy

        respond_to do |format|
            format.html { redirect_to gas_mileages_url }
            format.json { head :no_content }
        end
    end
end
