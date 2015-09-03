class VehiclesController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit, 
                                              :gfsearch1, :gfmatch1, :gfnew2,
                                              :svlist, :svsearch1,
                                              :match, :search_int1,
                                              ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit,
                                              :gfsearch1, :gfmatch1, :gfnew2,
                                              :svlist, :svsearch1,
                                              :match, :search_int1,
                                              ]
    include CustomersHelper
    include ApplicationHelper


    def prepFormVariables(make_id = nil)
        @makes = Make.find(:all, :order => 'name')
        @makeCollect = @makes.collect { |p|
            [ p.name, p.id ] 
        }
        if make_id.nil?
            @models = Model.find(:all, :order => 'name')
            @submodels = Submodel.find(:all, :order => 'name')
        else
            @models = Model.where("make_id = ?", make_id)
            @submodels = Submodel.where("make_id = ?", make_id)
        end
        @modelCollect = @models.collect { |p|
            [ p.name, p.id ] 
        }
        @submodelCollect = @submodels.collect { |p|
            [ p.name, p.id ] 
        }
        @states = State.all
        @stateCollect = @states.collect { |p|
            [ p.name, p.id ] 
        }
        @customers = Customer.find(:all, :order => 'last_name')
        @customerCollect = @customers.collect { |p|
            [ customerName2(p), p.id ] 
        }
        @stores = Store.all
        @storeCollect = @stores.collect { |p|
            [ p.number, p.id ] 
        }
        @countries = Country.find(:all, :order => 'name')
        @countryCollect = @countries.collect { |p|
            [ p.name, p.id ] 
        }
        @engineDisplacements = EngineDisplacement.find(:all, :order => 'name')
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
        @contracts = Contract.find(:all, :order => 'number')
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


    def svlist
        @vehicles = Vehicle.all
    end


    def gfindex
        @isGroundFloor = true
        index
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


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /vehicles/1/edit
    def edit
        @vehicle = Vehicle.find(params[:id])
        prepFormVariables
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def gfsearch1
        prepFormVariables
        prepDateCollects
    end


    def svsearch1
        @isSvSelect = true
        gfsearch1
    end


    def cleanUpForm
        par = params[:vehicle]
        if par[:msrp]
            par[:msrp] = par[:msrp].strip().delete(",")
        end
        if par[:kbb_on_qual]
            par[:kbb_on_qual] = par[:kbb_on_qual].strip().delete(",")
        end
        if par[:current_kbb]
            par[:current_kbb] = par[:current_kbb].strip().delete(",")
        end
        if par[:mileage]
            par[:mileage] = par[:mileage].strip().delete(",")
        end
    end


    def validateForm?(vehicle)
        ok = true
        vehicle.vin.strip!  if vehicle.vin
        vehicle.license_plate.strip!  if vehicle.license_plate
        if vehicle.license_plate_state_id.nil?
            ok = false
            addSessionError('You must select a state for the license plate.')
        end
        if vehicle.model_id.nil?
            ok = false
            addSessionError('You must select a model.')
        end
        if vehicle.engine_displacement_id.nil?
            ok = false
            addSessionError('You must select an engine displacement.')
        end
        if vehicle.wheel_drive_id.nil?
            ok = false
            addSessionError('You must select the wheel drive.')
        end
        if vehicle.color_id.nil?
            ok = false
            addSessionError('You must select the color.')
        end
        return ok
    end


    # POST /vehicles
    # POST /vehicles.json
    def create
        cleanUpForm
        @vehicle = Vehicle.new(params[:vehicle])
        p = params[:vehicle]
        # logger.info("==== create veh custid #{ @vehicle.customer_id }")
        ok = validateForm?(@vehicle)
        okUrl, errAction = setSaveAction('new', vehicles_url)
        errAction = 'gfnew2'  if errAction == 'gfnew'  # 2 step form

        respond_to do |format|
            if ok and @vehicle.save
                format.html { redirect_to okUrl,
                              notice: 'Vehicle was successfully created.' }
                format.json { render json: @vehicle, status: :created,
                                     location: @vehicle }
            else
                if errAction == 'gfnew2'
                    prepFormVariables(@vehicle.make_id)
                    @vehicle_customer_id = @vehicle.customer_id
                    @vehicle_make_id = @vehicle.make_id
                    @vehicle_contract_id = @vehicle.contract_id
                else
                    prepFormVariables
                end
                format.html { render action: errAction }
                format.json { render json: @vehicle.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    def validateFormnew1(veh)
        ok = true
        if veh.customer_id.nil? or veh.customer_id.to_i == 0
            ok = false
            addSessionError('You must select a Customer')
        end
        if veh.make_id.nil? or veh.make_id.to_i == 0
            ok = false
            addSessionError('You must select a Make')
        end
        if veh.contract_id != nil and veh.contract_id.to_i != 0
            conflict = Vehicle.where("contract_id = ?", veh.contract_id.to_i)
            if conflict.length > 0
                ok = false
                msg = 'Another vehicle (' + conflict.first.ymmText +
                      ') already has that contract.'
                addSessionError(msg)
            end
        end
        return ok
    end


    def prevalidateContract(veh)
        ok = true
        vpar = params[:vehicle]
        if vpar[:contract_id] 
            newContractId = vpar[:contract_id].to_i
            if newContractId > 0 and veh.contract_id != newContractId 
                conflict = Vehicle.where("contract_id = ?", newContractId)
                if conflict.length > 0
                    ok = false
                    msg = 'Another vehicle (' + conflict.first.ymmText +
                          ') already has that contract.'
                    addSessionError(msg)
                end
            end
        end
        return ok
    end


    # POST /vehicles/gfnew2, from _formnew1.html.erb
    #
    def gfnew2
        @vehicle = Vehicle.new(params[:vehicle])
        valid = validateFormnew1(@vehicle)

        if valid
            prepFormVariables(@vehicle.make_id)
            @vehicle_customer_id = @vehicle.customer_id
            @vehicle_make_id = @vehicle.make_id
            @vehicle_contract_id = @vehicle.contract_id
        else
            prepFormVariables
            render :gfnew
        end
    end


    # PUT /vehicles/1
    # PUT /vehicles/1.json
    def update
        if params[:new_sv]
            redirect_to '/service_visits/gfnew1/' + params[:id]
            return
        end
        @vehicle = Vehicle.find(params[:id])
        preok = prevalidateContract(@vehicle)

        respond_to do |format|
            @vehicle.assign_attributes(params[:vehicle])
            parok = validateForm?(@vehicle)
            okUrl, errAction = setSaveAction('edit', vehicles_url)
            saveok = false
            if parok and preok
                saveok = @vehicle.save
            end
            if parok and preok and saveok
                format.html { redirect_to okUrl,
                              notice: 'Vehicle was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @vehicle.errors,
                                     status: :unprocessable_entity }
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
        @target_label = params[:target_label]

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


    def gfmatch
        match
    end

end
