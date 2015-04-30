class VehiclesController < ApplicationController

    before_filter :only_allow_admins
    include CustomersHelper

    def prepFormVariables
        @makes = Make.all
        @makeCollect = @makes.collect { |p|
            [ p.name, p.id ] 
        }
        @models = Model.all
        @modelCollect = @models.collect { |p|
            [ p.name, p.id ] 
        }
        @submodels = Submodel.all
        @submodelCollect = @submodels.collect { |p|
            [ p.name, p.id ] 
        }
        @states = State.all
        @stateCollect = @states.collect { |p|
            [ p.name, p.id ] 
        }
        @customers = Customer.all
        @customerCollect = @customers.collect { |p|
            [ customerName2(p), p.id ] 
        }
        @stores = Store.all
        @storeCollect = @stores.collect { |p|
            [ p.number, p.id ] 
        }
        @countries = Country.all
        @countryCollect = @countries.collect { |p|
            [ p.name, p.id ] 
        }
        @engineDisplacements = EngineDisplacement.all
        @engineDisplacementCollect = @engineDisplacements.collect { |p|
            [ p.name, p.id ] 
        }
        @wheelDrives = WheelDrive.all
        @wheelDriveCollect = @wheelDrives.collect { |p|
            [ p.name, p.id ] 
        }
        @colors = Color.all
        @colorCollect = @colors.collect { |p|
            [ p.name, p.id ] 
        }
        @contracts = Contract.all
        @contractCollect = @contracts.collect { |p|
            [ p.number, p.id ] 
        }
        @insuranceCompanies = InsuranceCompany.all
        @insuranceCompanyCollect = @insuranceCompanies.collect { |p|
            [ p.name, p.id ] 
        }
    end

    # GET /vehicles
    # GET /vehicles.json
    def index
        @vehicles = Vehicle.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @vehicles }
        end
    end

    # GET /vehicles/1
    # GET /vehicles/1.json
    def show
        @vehicle = Vehicle.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @vehicle }
        end
    end

    # GET /vehicles/new
    # GET /vehicles/new.json
    def new
        @vehicle = Vehicle.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @vehicle }
        end
    end

    # GET /vehicles/1/edit
    def edit
        @vehicle = Vehicle.find(params[:id])
        prepFormVariables
    end

    def validateForm(vehicle)
        par = params[:vehicle]
        if par[:msrp]
            par[:msrp] = par[:msrp].strip().delete(",")
            # logger.info("==== set msrp to #{par[:msrp]}")
        end
        if par[:kbb_on_qual]
            par[:kbb_on_qual] = par[:kbb_on_qual].strip().delete(",")
        end
        if par[:current_kbb]
            par[:current_kbb] = par[:current_kbb].strip().delete(",")
        end
        return true
    end

    # POST /vehicles
    # POST /vehicles.json
    def create
        @vehicle = Vehicle.new(params[:vehicle])
        valid = validateForm(@vehicle)

        respond_to do |format|
            if valid and @vehicle.save
                format.html { redirect_to vehicles_url,
                              notice: 'Vehicle was successfully created.' }
                format.json { render json: @vehicle, status: :created, location: @vehicle }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @vehicle.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /vehicles/1
    # PUT /vehicles/1.json
    def update
        @vehicle = Vehicle.find(params[:id])
        valid = validateForm(@vehicle)

        respond_to do |format|
            if valid and @vehicle.update_attributes(params[:vehicle])
                format.html { redirect_to vehicles_url,
                              notice: 'Vehicle was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @vehicle.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /vehicles/1
    # DELETE /vehicles/1.json
    def destroy
        @vehicle = Vehicle.find(params[:id])
        @vehicle.destroy

        respond_to do |format|
            format.html { redirect_to vehicles_url }
            format.json { head :no_content }
        end
    end
end
