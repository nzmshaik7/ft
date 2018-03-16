class StoresController < ApplicationController

    before_action :database_area, :except =>[:store_list
    				]
    include CustomersHelper
    include ApplicationHelper
    include QualificationsHelper
    include ServiceLineItemsHelper


    def prepFormVariables
        @states = State.all
        @stateCollect = @states.collect { |p|
            [ p.name, p.id ] 
        }
        @employees = Employee.all
        @employeeCollect = @employees.collect { |p|
            [ p.nameText, p.id ] 
        }
        @counties = County.all
        @countyCollect = @counties.collect { |p|
            [ p.name, p.id ] 
        }
        @regions = Region.all
        @regionCollect = @regions.collect { |p|
            [ p.name, p.id ] 
        }

	#StoreName Collection
	@stores = Store.all
	@nameCollect = @stores.collect {|p| [p.name, p.id]}
    end

    def prepSearchVariables
    	yearFuture = 5
	now = Time.now
    #Years Collection
	@yearsCollect = Array.new
        thisYear = Time.now.year
        for yr in thisYear - 10 .. thisYear + yearFuture
            @yearsCollect.push([ yr, yr ])
        end
        @selStYear = thisYear
        @selEnYear = thisYear
    #Months Collection
        @monthsCollect = Array.new
        for mn in 1 .. 12
            mtime = Time.local(2000, mn, 15, 1, 1, 1)
            @monthsCollect.push([ mtime.strftime("%b"), mtime.mon ])
        end
        @selStMonth = 1
        @selEnMonth = 12
    #Days Collection
         @daysCollect = Array.new
        for dy in 1 .. 31
            @daysCollect.push([ dy, dy ])
        end
        @selStDay = 1
        @selEnDay = 1

    end

    def search_store_pl
	prepFormVariables
	prepSearchVariables
    end
     def search_single_store
	prepFormVariables
	prepSearchVariables
    end


  

    def match_for_store_pl
	prepFormVariables
	prepSearchVariables
	match2
	@store_profit_losses = StoreProfitLoss.all
	@total_profit_loss = 0.0
	$pl_count = Array.new
	$pl_count = [0,0,0]
	@temp1 = Array.new
	@temp2 = Array.new
	@temp3 = Array.new
	_k = -1
	define_singleton_method(:k) do
  		_k += 1
	end
	_l = -1
	define_singleton_method(:l) do
  		_l += 1
	end
	_m = -1
	define_singleton_method(:m) do
  		_m += 1
	end

	@stores.each do |i|
		@store_profit_losses.each do |j|
			if i.id == j.id
				@total_profit_loss += j.profit_loss
				if j.profit_loss >0
					$pl_count[0] += 1
				elsif j.profit_loss == 0 
					$pl_count[1] += 1
				else
					$pl_count[2] +=1
				end
				@temp1[k] = j
				
			end
		end
	end

	@store_to_service_visits = StoreToServiceVisit.all
	@sv_count = 0.0
	@count = 0.0
	$Yield = Array.new
	$Yield = [0,0,0]
	@Y = 0.0
	@stores.each do |i|
		@store_to_service_visits.each do |j|
			if i.id == j.id
				@sv_count += j.service_visit_count
 				@count += 1
				@Y = (j.profit_loss/j.service_visit_count).round(3)
				if @Y >0
					$Yield[0] += 1
				elsif j.profit_loss == 0 
					$Yield[1] += 1
				else
					$Yield[2] +=1
				end
				@temp2[l] = j
				
			end
		end
	end
	@sv_avg = (@sv_count/@count).round(3)
	@pl_sv_ratio = (@total_profit_loss/@sv_count).round(3)	
	

	#@store_flags = StoreFlag.all
	@store_flags = ActiveRecord::Base.connection.execute("call store_flags()")
	ActiveRecord::Base.clear_active_connections!
	@employees = Employee.all
	@stores.each do |i|
		@store_flags.each do |j|
			if i.id == j[0]
				@temp3[m] = j
			end
		end
	end
	

	
    end

   def pie_pl
	@count = Array.new
	@count = $pl_count
	return @count
   end

  def pie_sv
	@count = Array.new
	@count = $Yield
	return @count
   end

    def match_for_single_store
	prepFormVariables
	prepSearchVariables
	match3
	@vehicle_profit_losses = VehicleProfitLoss.all
	@total_profit_loss = 0.0

	@temp1 = Array.new
	@temp2 = Array.new
	@temp3 = Array.new
	_k = -1
	define_singleton_method(:k) do
  		_k += 1
	end
	_l = -1
	define_singleton_method(:l) do
  		_l += 1
	end
	_m = -1
	define_singleton_method(:m) do
  		_m += 1
	end

	@stores.each do |i|
		@vehicle_profit_losses.each do |j|
			if j.store_id == i.id
				@total_profit_loss += j.profit_loss 
				@temp1[k] = j
			end
		end
	
	end

	@store_technician_details = StoreTechnicianDetails.all

	@stores.each do |i|
		@store_technician_details.each do |j|
			if j.store_id == i.id 
				@temp2[l] = j
			end
		end
	
	end

	@store_stocks = StoreStock.all
	$inventory_total = 0.0
	$used_total = 0.0
	@stores.each do |i|
		@store_stocks.each do |j|
			if j.store_id == i.id 
				@temp3[m] = j
				$inventory_total += j.inventory_parts
				$used_total += j.used_parts
				
			end
		end
	
	end

    end
    



 def match2
        @target_cm = params[:target_cm]
        if @target_cm and @target_cm[0] == '/'  # Whack leading slash
            @target_cm = @target_cm[1..-1] 
        end
        @target_label = params[:target_label]
        @isGroundFloor = true  if formHasGf?

        whereHash = Hash.new
        whereClause = ''
        andop = ''
        veh = params[:store]

	if veh[:state] and veh[:state].to_i > 0
            whereHash[:state_id] = veh[:state]
            whereClause += andop + " state_id = :state_id"
            andop = ' AND'
        end

        if veh[:region] and veh[:region].to_i > 0
            whereHash[:region_id] = veh[:region]
            whereClause += andop + " region_id = :region_id"
            andop = ' AND'
        end

	if veh[:county] and veh[:county].to_i > 0
            whereHash[:county_id] = veh[:county]
            whereClause += andop + " county_id = :county_id"
            andop = ' AND'
        end

        if veh[:manager] and veh[:manager].to_i > 0
            whereHash[:manager_id] = veh[:manager]
            whereClause += andop + " manager_id = :manager_id"
            andop = ' AND'
        end

        logger.info("==== whereHash: #{whereHash.inspect}")
        logger.info("==== whereClause: #{whereClause}")

        if whereClause == ''
            @stores = Store.all
        else
            @stores = Store.where(whereClause, whereHash)
        end

    end


 def match3
        @target_cm = params[:target_cm]
        if @target_cm and @target_cm[0] == '/'  # Whack leading slash
            @target_cm = @target_cm[1..-1] 
        end
        @target_label = params[:target_label]
        @isGroundFloor = true  if formHasGf?

        whereHash = Hash.new
        whereClause = ''
        andop = ''
        veh = params[:store]

        if veh[:name] and veh[:name].to_i > 0
            whereHash[:id] = veh[:name]
            whereClause += andop + " id = :id"
            andop = ' AND'
        end

        logger.info("==== whereHash: #{whereHash.inspect}")
        logger.info("==== whereClause: #{whereClause}")

        if whereClause == ''
            @stores = Store.all
        else
            @stores = Store.where(whereClause, whereHash)
        end

    end




    # GET /stores
    # GET /stores.json
    def index
        @stores = Store.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @stores }
        end
    end

    def store_list
	@isGroundFloor = true
	index
    end

    # GET /stores/1
    # GET /stores/1.json
    def show
        @store = Store.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @store }
        end
    end

    # GET /stores/new
    # GET /stores/new.json
    def new
        @store = Store.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @store }
        end
    end

    # GET /stores/1/edit
    def edit
        @store = Store.find(params[:id])
        prepFormVariables
    end

    # POST /stores
    # POST /stores.json
    def create
        @store = Store.new(params.require(:store).permit(:break_even, :capacity, :city, :county_id, :manager_id,
                    :name, :number, :number_of_lifts, :phone, :region_id,
                    :state_id, :street_address, :zip))

        respond_to do |format|
            if @store.save
                format.html { redirect_to stores_url,
                              notice: 'Store was successfully created.' }
                format.json { render json: @store, status: :created, location: @store }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @store.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /stores/1
    # PUT /stores/1.json
    def update
        @store = Store.find(params[:id])

        respond_to do |format|
            if @store.update_attributes(params.require(:store).permit(:break_even, :capacity, :city, :county_id, :manager_id,
                    :name, :number, :number_of_lifts, :phone, :region_id,
                    :state_id, :street_address, :zip))
                format.html { redirect_to stores_url,
                              notice: 'Store was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @store.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /stores/1
    # DELETE /stores/1.json
    def destroy
        @store = Store.find(params[:id])
        @store.destroy

        respond_to do |format|
            format.html { redirect_to stores_url }
            format.json { head :no_content }
        end
    end
end
