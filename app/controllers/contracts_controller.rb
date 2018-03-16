class ContractsController < ApplicationController

    before_action :database_area, :except => [:gfnew, :gfindex, :gfedit, :match, :match_for_plan_vehicles, :search_plan_vehicles]
    before_action :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, :match, :match_for_plan_vehicles, :search_plan_vehicles]

    include ApplicationHelper
    include CustomersHelper


    def prepFormVariables(contract)

        # @vehicles will be used later.
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ] 
        }

        @stores = Store.all
        @storeCollect = @stores.collect { |p|
            [ p.name, p.id ] 
        }

        @salespersons = Salesperson.all
        @salespersonCollect = @salespersons.collect { |p|
            [ p.employee.nameText, p.id ] 
        }

        @selStatus = 0
        if contract
            if [Contract::STATUS_CURRENT, Contract::STATUS_LAPSED, 
                Contract::STATUS_CANCELLED].include?(contract.status)
                @selStatus = contract.status
            end
        end
        @statusOptions = [
            [ "Select",      0  ],
            [ "Current",     51 ],
            [ "Lapsed",      52 ],
            [ "Cancelled",   53 ],
        ]
    end

    def prepSearchVariables

	#@base_costs = CboxInfo.all
	#@enrollment_planCollect = @enrollment_plans.collect {|p| [p.name, p.id]}
	#@base_costs = CBoxInfo.find(params[:code==1])
	#@base_costCollect = @base_costs.collect {|p| [p.name, p.id] }

	@baseCostCollect = [
		["29.99", 1],
		["39.99", 2],
		["49.99", 3],
		["69.99", 4],
		["99.99", 5],
	]

    end

    def match_for_plan_vehicles
	@vehicle_profit_losses = VehicleProfitLoss.all
	
	@total_profit_loss = 0.0
	@profit_loss = Array.new
	@profit_loss = [0,0,0]
	match
	prepSearchVariables
    end

    def search_plan_vehicles
	prepSearchVariables
    end


    def match
	
	
        @target_cm = params[:target_cm]
        if @target_cm and @target_cm[0] == '/'  # Whack leading slash
            @target_cm = @target_cm[1..-1] 
        end
        @target_label = params[:target_label]
        @isGroundFloor = true  if formHasGf?


        whereHash = Hash.new
        whereClause = ''
        andop = ''
        con = params[:contract]

        if con[:plan] and con[:plan].to_i > 0
            whereHash[:base_cost] = con[:plan]
            whereClause += andop + " base_cost = :base_cost"
            andop = ' AND'
        end


        logger.info("==== whereHash: #{whereHash.inspect}")
        logger.info("==== whereClause: #{whereClause}")

        if whereClause == ''
            @contracts = Contract.all
        else
            @contracts = Contract.where(whereClause, whereHash)
        end

	
    end



    # GET /contracts
    # GET /contracts.json
    def index
        @contracts = Contract.all
        prepFormVariables(@contract)
	prepSearchVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @contracts }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /contracts/1
    # GET /contracts/1.json
    def show
        @contract = Contract.find(params[:id])
        prepFormVariables(@contract)
	prepSearchVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @contract }
        end
    end


    # GET /contracts/new
    # GET /contracts/new.json
    def new
        @contract = Contract.new
        prepFormVariables(@contract)
	prepSearchVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @contract }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /contracts/1/edit
    def edit
        @contract = Contract.find(params[:id])
        prepFormVariables(@contract)
	prepSearchVariables	
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validateContract?(contr)
        ok = true
        contr.number.strip!  if contr.number
        if contr.number.nil? or contr.number == ''
            ok = false
            addSessionError('Contract number is required field.')
        else
            conflict = Contract.where("number = ?", contr.number)
            if conflict.length > 0
                ok = false
                addSessionError('That Contract number is already in the ' +
                                'system.')
            end
        end
        if contr.status.nil? or contr.status == 0
            ok = false
            addSessionError('You must select a status.')
        end
        if contr.store.nil?
            ok = false
            addSessionError('You must select a store.')
        end
        if contr.level.nil? or contr.level == 0
            ok = false
            addSessionError('You must enter a level.')
        end
        if contr.base_cost.nil? or contr.base_cost == 0.0
            ok = false
            addSessionError('You must enter a base cost.')
        end
        if contr.day_of_payment.nil? or contr.day_of_payment == 0
            ok = false
            addSessionError('You must enter a day of payment.')
        end
        return ok
    end


    # POST /contracts
    # POST /contracts.json
    def create
        @contract = Contract.new(params.require(:contract).permit(:store_id, :base_cost, :begin_date, :day_of_payment, :discount, 
                    :discount, :image_id, :level, :number, :salesperson_id,
                    :status, :discount_percent))
        @contract.discount = 0.0  if @contract.discount.nil?
        @contract.discount_percent = 0  if @contract.discount_percent.nil?
        ok = validateContract?(@contract)
        okUrl, errAction = setSaveAction('new', contracts_url)

        respond_to do |format|
            if ok and @contract.save
                format.html { redirect_to okUrl,
                              notice: 'Contract was successfully created.' }
                format.json { render json: @contract, status: :created,
                                     location: @contract }
            else
                prepFormVariables(@contract)
		prepSearchVariables
                format.html { render action: errAction }
                format.json { render json: @contract.errors, 
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /contracts/1
    # PUT /contracts/1.json
    def update
        @contract = Contract.find(params[:id])

        respond_to do |format|
            @contract.assign_attributes(params.require(:contract).permit(:store_id, :base_cost, :begin_date, :day_of_payment, :discount, 
                    :discount, :image_id, :level, :number, :salesperson_id,
                    :status, :discount_percent))
            #parok = validateContract?(@contract)
            okUrl, errAction = setSaveAction('edit', contracts_url)
            saveok = false
            #if parok
            saveok = @contract.save
            #end
            #if parok and saveok
	    if saveok
                format.html { redirect_to okUrl,
                              notice: 'Contract was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@contract)
		prepSearchVariables
                format.html { render action: errAction }
                format.json { render json: @contract.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /contracts/1
    # DELETE /contracts/1.json
    def destroy
        @contract = Contract.find(params[:id])
        @contract.destroy

        respond_to do |format|
            format.html { redirect_to contracts_url }
            format.json { head :no_content }
        end
    end
end
