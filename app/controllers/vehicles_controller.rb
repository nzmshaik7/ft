class VehiclesController < ApplicationController

    before_filter :database_area
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

    
    def prepSearchVariables
        @yearsCollect = Array.new
        thisYear = Time.now.year
        for yr in thisYear - 15 .. thisYear + 1
            @yearsCollect.push([ yr, yr ])
        end
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


    def search_int1
        prepFormVariables
        prepSearchVariables
    end


    # Get search criteria from form and find all matching vehicles.
    # View will render a list of hyperlinks that will point to the
    # given controller and method page for that vehicle.
    #
    def match
        @target_cm = params[:target_cm]
        if @target_cm and @target_cm[0] == '/'  # Whack leading slash
            @target_cm = @target_cm[1..-1] 
        end

        whereHash = Hash.new
        whereClause = ''
        andop = ''
        veh = params[:vehicle]

        if veh[:year]
            yr = veh[:year].to_i
            if yr > 1990 and yr < 2215
                whereHash[:start_date] = "#{yr}-01-01 00:00:01"
                whereHash[:end_date] =   "#{yr}-12-31 23:59:59"
                whereClause += andop + 
                                   " date_of_manufacture >= :start_date AND "
                whereClause += "date_of_manufacture <= :end_date"
                andop = ' AND'
            end
        end

        if veh[:make] and veh[:make].to_i > 0
            whereHash[:make_id] = veh[:make]
            whereClause += andop + " make_id = :make_id"
            andop = ' AND'
        end

        if veh[:model] and veh[:model].to_i > 0
            whereHash[:model_id] = veh[:model]
            whereClause += andop + " model_id = :model_id"
            andop = ' AND'
        end

        if veh[:license_plate] and veh[:license_plate].length > 0
            whereHash[:license_plate] = "%#{ veh[:license_plate] }%"
            whereClause += andop + " license_plate like :license_plate"
            andop = ' AND'
        end

        if veh[:license_plate_state] and veh[:license_plate_state].to_i > 0
            whereHash[:plate_id] = veh[:license_plate_state]
            whereClause += andop + " license_plate_state_id = :plate_id"
            andop = ' AND'
        end

        if veh[:minimum_mileage] and veh[:minimum_mileage].length > 0
            whereHash[:minmile] = veh[:minimum_mileage]
            whereClause += andop + " mileage >= :minmile"
            andop = ' AND'
        end
        if veh[:maximum_mileage] and veh[:maximum_mileage].length > 0
            whereHash[:maxmile] = veh[:maximum_mileage]
            whereClause += andop + " mileage <= :maxmile"
            andop = ' AND'
        end

        logger.info("==== whereHash: #{whereHash.inspect}")
        logger.info("==== whereClause: #{whereClause}")

        if whereClause == ''
            @vehicles = Vehicle.all
        else
            @vehicles = Vehicle.where(whereClause, whereHash)
        end
    end

end
