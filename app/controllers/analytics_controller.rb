
class AnalyticsController < ApplicationController

    before_action :database_area
    include CustomersHelper
    include QualificationsHelper
    include ServiceLineItemsHelper
    include ApplicationHelper



    def prepFormVariables(veh)
        now = Time.now
        prepDateCollects

#        @custDays = (((Time.now - veh.customer.joined_date) / 3600) / 24).to_i
        if veh.customer.date_of_birth
            @custAge = now.year - veh.customer.date_of_birth.year
        else
            @custAge = 0
        end
        if veh.customer.written_testimony_id
            @custWrittenTestimony = WrittenTestimony.find(
                                             veh.customer.written_testimony_id)
        else
            @custWrittenTestimony = nil
        end
    end



    def junkPrepFormVariables
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

    

    
    def calcProfitLoss(veh)

        @qualRetail = 0.0
        @qualLaborActual = 0.0
        @qualPartsActual = 0.0
        @membIncome = 0.0       # All payments
        @membClubFees = 0.0     # Club fees only
        @membLaborActual = 0.0  # Covered service and repair only
        @membPartsActual = 0.0  # Covered service and repair only
        @membScheduled = 0.0    # Covered service, parts and labor
        @membUnscheduled = 0.0  # Covered repair, parts and labor
        @notCoveredIncome = 0.0
        @notCoveredLaborActual = 0.0
        @notCoveredPartsActual = 0.0
        @otherIncome = 0.0
        @otherLaborActual = 0.0
        @otherPartsActual = 0.0

        for svisit in veh.service_visits
            if svisit.status != ServiceVisit::STATUS_COMPLETED
                next
            end
            for sli in svisit.service_line_items
		setTotalsForSvcLineItem(sli)
                if sli.stype == ServiceLineItem::S_QUALIFICATION
                    @qualRetail += @sliTotLaborRetail
                    @qualLaborActual += @sliTotLaborActual
                    @qualRetail += @sliTotPartsRetail
                    @qualPartsActual += @sliTotPartsActual
                elsif sli.stype == ServiceLineItem::S_MEMB_SERVICE
                    @membLaborActual += @sliTotLaborActual
                    @membScheduled +=   @sliTotLaborActual
                    @membPartsActual += @sliTotPartsActual
                    @membScheduled +=   @sliTotPartsActual
                elsif sli.stype == ServiceLineItem::S_MEMB_REPAIR
                    @membLaborActual += @sliTotLaborActual
                    @membUnscheduled += @sliTotLaborActual
                    @membPartsActual += @sliTotPartsActual
                    @membUnscheduled += @sliTotPartsActual
                elsif sli.stype == ServiceLineItem::S_MEMB_NOT_COVERED
                    @notCoveredIncome += @sliTotLaborRetail
                    @notCoveredLaborActual += @sliTotLaborActual
                    for sp in sli.service_parts
                        @notCoveredIncome += sp.part_retail_price
                        @notCoveredPartsActual += sp.part_actual_price
                    end
                else
                    @otherIncome += @sliTotLaborRetail
                    @otherLaborActual += @sliTotLaborActual
                    for sp in sli.service_parts
                        @otherPartsActual += sp.part_actual_price
                        @otherIncome += sp.part_retail_price
                    end
                end
            end
        end

        for payment in Payment.where("contract_id = ?", veh.contract_id)
            if payment.status == Payment::STATUS_APPOVED
                @membIncome += payment.amount
                if payment.contract
                    @membClubFees += payment.amount
                end
            end
        end

        @totalIncome = @qualRetail + @membIncome + @notCoveredIncome
        @totalPartsCost = @qualPartsActual + @membPartsActual +
                                             @notCoveredPartsActual
        @totalLaborCost = @qualLaborActual + @membLaborActual + 
                                             @notCoveredLaborActual
        @totalCost = @totalPartsCost + @totalLaborCost
        @profit = @totalIncome - @totalCost
        if @totalIncome == 0.0
            @profitPercent = 0.0
        else
            @profitPercent = @profit * 100.0 / @totalIncome
        end
    end

    # d1 = feb 4, d2 = jan 3, wholeMonths = -1
    # d1 = jan 4, d2 = feb 3, wholeMonths = 0
    # d1 = feb 2, d2 = jan 3, wholeMonths = 0
    def monthDelta(d1, d2)
	wholeMonths = (d2.year * 12 + d2.month) - (d1.year * 12 + d1.month)
	if wholeMonths < 0
	    if d2.day >= d1.day
		wholeMonths += 1
	    end
	else
	    if d2.day <= d1.day
		wholeMonths -= 1
	    end
	end
	return wholeMonths
    end


    def dateMin(d1, d2)
        if d1 < d2
	    return d1
	else
	    return d2
	end
    end
    
    
    # Set up missed payment info for finance agreement area.
    #
    def calcFinanceAgreements(veh)
	@finagrmtHash = Hash.new  # Hash of hashes
        for finagrmt in veh.customer.finance_agreements
	    @finagrmtHash[finagrmt.id] = Hash.new
	    # Find all the payments that should have happened in the
	    # past.  Look through the invoices to see if you can find
	    # that many payments for this finance agreement.  Do calculation
	    # in dollars rather than count, so that you can handle doubled
	    # up payments.  Payments
	    dupto = dateMin(Time.now, finagrmt.end_date)
	    paymentsDueSoFar = monthDelta(finagrmt.start_date, dupto)
	    amtDueSoFar = paymentsDueSoFar * finagrmt.monthly_payment_amount
	    amtPaidSoFar = 0.0
	    pastDueAmt = 0.0
	    @finagrmtHash[finagrmt.id][:missedPayments] = 0
	    q = "finance_agreement_id = ? and status = "
	    q += Payment::STATUS_APPOVED.to_s
	    @finagrmtHash[finagrmt.id][:paymentList] = 
	                                          Payment.where(q, finagrmt.id)
	    for payForThis in @finagrmtHash[finagrmt.id][:paymentList]
	        amtPaidSoFar += payForThis.amount
	    end
	    if amtPaidSoFar < amtDueSoFar
	        pastDueAmt = amtDueSoFar - amtPaidSoFar 
		mPay = finagrmt.monthly_payment_amount
		# Round up for partial payments, they count as whole.
		@finagrmtHash[finagrmt.id][:missedPayments] = 
					((pastDueAmt + mPay - 1.0) / mPay).to_i
	    end
	    @finagrmtHash[finagrmt.id][:income] = amtPaidSoFar
	    principalPaid = amtPaidSoFar - 
			    (finagrmt.missed_payment_fee + finagrmt.finance_fee)
	    @finagrmtHash[finagrmt.id][:balance] = 
	                               finagrmt.total_principal - principalPaid
	end
    end
    
    
    def calcVehicleInfo(veh)
        @adliSerials = Array.new
        for dli in veh.automatic_data_link_infos
            sn = dli.serial_number
            if sn.nil? or sn == ''
                sn = 'n/a'
            end
            if not @adliSerials.include?(sn)
                @adliSerials.push(sn)
            end
        end
    end

#######################################################################################################################################

    def veh_profit_loss
	@vpl = VehicleProfitLoss.all
	@p = 0.0
	@l = 0.0
	temp1 = 0.0
	temp2 = 0.0
	@vpl.each do |i|
		if i.profit_loss >= 0
			if temp1 <= i.profit_loss
				@p = i
				temp1 = i.profit_loss
			end
		else
			if temp2 > i.profit_loss
				@l = i
				temp2 = i.profit_loss
			end
		end
	end
	if @p == 0.0
		@p_margin = -1	
	else
		@p_margin = (temp1/@p.vehicle_revenue)*100
	end
	if @l == 0.0
		@l_margin = -1
	else
		@l_margin = (temp2/@l.vehicle_revenue)*100
	end

	@total_pl = Array.new
	@total_pl = total_profit_loss
	@p_morethan_avg = temp1-@total_pl[1]
	@p_morethan_total = temp1-@total_pl[0]
	@l_lessthan_avg = @total_pl[1] + temp2
	@l_lessthan_total = @total_pl[0] + temp2
	
	@pl = Array.new
	#pl[veh_id_with_prifit,2.veh_id_with_loss, 3.veh_profit%, 4.veh_loss%, 5. veh_profit_morethan_avg, 
	#	6. veh_profit_morethan_total, 7. veh_loss_lessthan_Avg, 8. Veh_loss_lessthan_total]
	@pl = [@p, @l,@p_margin, @l_margin, @p_morethan_avg, @p_morethan_total, @l_lessthan_avg, @l_lessthan_total]
	return @pl
    end

    def veh_count_based_on_average_profit
	@total_pl = Array.new
	@total_pl = total_profit_loss
	@more_than_average = 0
	@less_than_average = 0
	
	@vpl = VehicleProfitLoss.all
	@vpl.each do |i|
		if i.profit_loss >= @total_pl[1]
			@more_than_average += 1
		else
			@less_than_average += 1
		end
	end
	@more_less = Array.new
	@more_less = [@more_than_average, @less_than_average]
	return @more_less
    end

    def total_profit_loss
	@vpl = VehicleProfitLoss.all
	@pl_value = 0.0
	@count = 0.0
	@vpl.each do |i|
		@pl_value += i.profit_loss
		@count += 1
	end
	if @count >0 
		@average_pl = @pl_value/@count
	else
		@average_pl = 0
	end
	@total_pl = Array.new
	
	@total_pl = [@pl_value, @average_pl]
	return @total_pl
    end
######################################################################################################################################
    
    def basic
	 @vehicle = Vehicle.find($vid)
        return  
    end
    
    def pie
	@vehicle = Vehicle.find($vid)
        return  
    end
    
    def bar
	@vehicle = Vehicle.find($vid)  
        return  
    end

  
    
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*


    def colorCount
	@colorName = Color.all
	@veh	   = Vehicle.all
	
	
	colorHash = Hash.new

	@colorName.each do |i|
		colorHash.store(i.name,0)
	end
	

	 

	 @colorName.each do |i| 
		@veh.each do |j|
			if i.name == j.color.name
				@k = colorHash.fetch(i.name) + 1
				colorHash[i.name] = @k
			end
		end 

	end 
	return colorHash

    end


    def bar_int2
	@bar_int2 = Hash.new
	@bar_int2.merge!(colorCount)
	
	return @bar_int2
	
	
    end

    def engineDispCount
	@engineDispName = EngineDisplacement.all
	@veh	   = Vehicle.all
	
	
	engineDispHash = Hash.new

	@engineDispName.each do |i|
		engineDispHash.store(i.name,0)
	end
	
	 @engineDispName.each do |i| 
		@veh.each do |j|
			if i.name == j.engine_displacement.name
				@k = engineDispHash.fetch(i.name) + 1
				engineDispHash[i.name] = @k
			end
		end 

	end 
	return engineDispHash

    end

    def bar_int3
	@bar_int3 = Hash.new
	@bar_int3.merge!(engineDispCount)
	
	return @bar_int3
    end

    def engineCyl
   	@veh = Vehicle.all
	engineCylHash = Hash.new
	engineCylHash.store(4,0)
	engineCylHash.store(6,0)
	engineCylHash.store(8,0)

	@veh.each do |i|
		if i.engine_cyl == 4
			engineCylHash[4] = engineCylHash.fetch(4) + 1
		elsif i.engine_cyl == 6
			engineCylHash[6] = engineCylHash.fetch(6) + 1
		else
			engineCylHash[8] = engineCylHash.fetch(8) + 1
		end
	end
	return engineCylHash
    end


    def bar_int4
	@bar_int4 = Hash.new
	@bar_int4.merge!(engineCyl)
	
	return @bar_int4
    end

    def makeCount
	@makeName = Make.all
	@veh	   = Vehicle.all
	
	
	makeHash = Hash.new

	@makeName.each do |i|
		makeHash.store(i.name,0)
	end
	

	 

	 @makeName.each do |i| 
		@veh.each do |j|
			if i.name == j.make.name
				@k = makeHash.fetch(i.name) + 1
				makeHash[i.name] = @k
			end
		end 
	end 
	return makeHash
    end

    def bar_int5
	@bar_int5 = Hash.new
	@bar_int5.merge!(makeCount)
	
	return @bar_int5
    end

    def mileagediff
	@veh	   = Vehicle.all

	mileageHash = Hash.new
	mileageHash.store(2000,0)
	mileageHash.store(5000,0)
	mileageHash.store(10000,0)
	mileageHash.store(12000,0)

	@veh.each do |i|
		@k =   i.mpg30after_initial - i.mileage

		if @k <=2000
			mileageHash[2000] = mileageHash.fetch(2000) + 1
		elsif @k <= 5000
			mileageHash[5000] = mileageHash.fetch(5000) + 1 
		elsif @k <= 1000
			mileageHash[10000] = mileageHash.fetch(10000) + 1 
		else
			mileageHash[12000] = mileageHash.fetch(12000) + 1 
		end
	end
	return mileageHash
    end
    

    def pie_mileagediff
	@pie_md = Hash.new
	@pie_md.merge!(mileagediff)
	
	return @pie_md
    end
 
    def vehPayment
	pmnt = Array.new
	@paySuccess = 15
	@payFail = 2
	@payLate = 7
	
	pmnt = [@paySuccess, @payFail, @payLate]
	return pmnt
    end
    

    def pie_payment
	@pie_payment = Array.new
	@pie_payment = vehPayment
	
	return @pie_payment
    end

  


 
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

    def int2

	bar_int2
	bar_int3
	bar_int4
	bar_int5
	pie_mileagediff

	pie_payment
	@pl = Array.new
	@pl = veh_profit_loss
	@total_pl = Array.new
	@total_pl = total_profit_loss
	@more_less = Array.new
	@more_less = veh_count_based_on_average_profit

	
    end


#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores

    def store_profit_loss
	@spl = StoreProfitLoss.all
	@p = 0.0
	@l = 0.0
	temp1 = 0.0
	temp2 = 0.0
	@spl.each do |i|
		if i.profit_loss >= 0
			if temp1 <= i.profit_loss
				@p = i
				temp1 = i.profit_loss
			end
		else
			if temp2 > i.profit_loss
				@l = i
				temp2 = i.profit_loss
			end
		end
	end
	if @p == 0.0 
		@p_margin = -1
	else
		@p_margin = (temp1/@p.store_revenue)*100
	end
	if @l == 0.0 
		@l_margin = -1
	else
		@l_margin = (temp2/@l.store_revenue)*100
	end

	@total_pl = Array.new
	@total_pl = store_total_avg_pl
	@p_morethan_avg = temp1-@total_pl[1]
	@p_morethan_total = temp1-@total_pl[0]
	@l_lessthan_avg = @total_pl[1] - temp2
	@l_lessthan_total = @total_pl[0] - temp2
	
	@pl = Array.new
	#pl[store_id_with_profit,2.store_id_with_loss, 3.store_profit%, 4.store_loss%, 5. store_profit_morethan_avg, 
	#	6. store_profit_morethan_total, 7. store_loss_lessthan_Avg, 8. store_loss_lessthan_total]
	@pl = [@p, @l,@p_margin, @l_margin, @p_morethan_avg, @p_morethan_total, @l_lessthan_avg, @l_lessthan_total]
	return @pl
    end

    def store_count_wrt_avg_pl
    # Returns store count wrt morethan average and lessthan average. [0] => morethan; [1] => lessthan
	@total_ave_pl = Array.new
	@total_avg_pl = store_total_avg_pl
	@more_than_average = 0
	@less_than_average = 0
	
	@spl = StoreProfitLoss.all
	@spl.each do |i|
		if i.profit_loss >= @total_avg_pl[1]
			@more_than_average += 1
		else
			@less_than_average += 1
		end
	end
	@more_less = Array.new
	@more_less = [@more_than_average, @less_than_average]
	return @more_less
    end


    def store_total_avg_pl
    # Returns total and average values of profit/loss. [0] => total; [1] => average
	@spl = StoreProfitLoss.all
	@pl_value = 0.0
	@count = 0.0
	@spl.each do |i|
		@pl_value += i.profit_loss
		@count += 1
	end
	if @count >0 
		@average_pl = @pl_value/@count
	else
		@average_pl = 0
	end

	@total_avg_pl = Array.new
	@total_avg_pl = [@pl_value, @average_pl]
	return @total_avg_pl
    end



    def int3
    #profit/loss statistics
	@total_avg_pl = Array.new
	@total_avg_pl = store_total_avg_pl
	
	@more_less = Array.new
	@more_less = store_count_wrt_avg_pl

	@pl = Array.new
	@pl = store_profit_loss
	
    end
    
#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores#Stores
    
    # GET analytics/int1/:id
    def int1
        @vehicle = Vehicle.find(params[:id])
	$vid = params[:id]
        prepFormVariables(@vehicle)
        calcProfitLoss(@vehicle)
        calcInternal1(@vehicle)
        calcFinanceAgreements(@vehicle)
        calcVehicleInfo(@vehicle)

        ll = LocalLogger.new('/tmp/gengraph.txt')
        gg = Gengraph.new(ll)

        # Club fees pie chart
        gg.clubFeesPie(@vehicle, @membClubFees, @membScheduled,
                                                @membUnscheduled)
        grossProfit = @membClubFees - (@membScheduled + @membUnscheduled)
        totalf = @membScheduled + @membUnscheduled + grossProfit.abs
        @clubFeesLegend = Array.new
        @clubFeesLegend.push( { :color => '#c040ff', :label => 'Unscheduled', 
                                :percent => 100.0 * @membUnscheduled / totalf,
                                :amount => @membUnscheduled } )
        @clubFeesLegend.push( { :color => '#87cefa', :label => 'Scheduled', 
                                :percent => 100.0 * @membScheduled / totalf,
                                :amount => @membScheduled } )
        if grossProfit < 0.0
            color3 = '#ff4040'
            label3 = 'Gross Loss'
        else
            color3 = '#40ff40'
            label3 = 'Gross Profit'
        end
        @clubFeesLegend.push( { :color => color3, :label => label3, 
                                :percent => 100.0 * grossProfit.abs / totalf,
                                :amount => grossProfit.abs } )

        # Total Vehicle Profitability pie chart
        gg.profitabilityPie(@vehicle, @totalIncome, @totalPartsCost, 
                                                    @totalLaborCost) 

        @graphUrls = gg.getUrls


	

    end

    
    # GET analytics/non_ma_maint/:id
    def non_ma_maint
        @vehicle = Vehicle.find(params[:id])
    end
    
    
    def calcInternal1(veh)

        spd = 3600.0 * 24.0

        # mileage
        @latestMileageTime = nil
        @latestMileage = nil
        now = Time.now
        @nowYear = now.strftime("%Y")
        for gm in veh.gas_mileages
            if @latestMileageTime.nil? or gm.mdate > @latestMileageTime
                @latestMileageTime = gm.mdate
                @latestMileage = gm.mileage
            end
        end

        oldestMileageTime = nil
        oldestMileage = nil
        newestMileageTime = nil
        newestMileage = nil

        oldestMileageTimeRecent = nil
        oldestMileageRecent = nil
        newestMileageTimeRecent = nil
        newestMileageRecent = nil
        yearAgo = now - (365.2425 * 24 * 3600)

        for s_visit in veh.service_visits
            if s_visit.status != ServiceVisit::STATUS_COMPLETED
                next
            end
            if oldestMileageTime.nil? or s_visit.sdate < oldestMileageTime
                oldestMileageTime = s_visit.sdate
                oldestMileage = s_visit.mileage
            end
            if newestMileageTime.nil? or s_visit.sdate > newestMileageTime
                newestMileageTime = s_visit.sdate
                newestMileage = s_visit.mileage
            end
            if s_visit.sdate > yearAgo  # Was less than a year ago
                if oldestMileageTimeRecent.nil? or 
                                     s_visit.sdate < oldestMileageTimeRecent
                    oldestMileageTimeRecent = s_visit.sdate
                    oldestMileageRecent = s_visit.mileage
                end
                if newestMileageTimeRecent.nil? or 
                                     s_visit.sdate > newestMileageTimeRecent
                    newestMileageTimeRecent = s_visit.sdate
                    newestMileageRecent = s_visit.mileage
                end
            end
        end
        @avgMilesPerYear = nil
        @avgMilesPerYearRecent = nil
        if oldestMileageTime
            daySpan = (newestMileageTime.to_i - oldestMileageTime.to_i) / spd
            if daySpan > 30.0
                yearSpan = daySpan / 365.2425
                @avgMilesPerYear = (newestMileage - oldestMileage) / yearSpan
            end
        end
        if oldestMileageTimeRecent
            daySpan = (newestMileageTimeRecent.to_i - 
                       oldestMileageTimeRecent.to_i) / spd
            if daySpan > 30.0
                yearSpan = daySpan / 365.2425
                @avgMilesPerYearRecent = (newestMileageRecent - 
                                          oldestMileageRecent) / yearSpan
            end
        end

        # Miles under
        @allowedMiles = 15000
        for upg in veh.contract.upgrades
            if upg.upgrade_type.added_miles
                @allowedMiles += upg.upgrade_type.added_miles
            end
        end

        # Referrals
        @referredCust = Customer.where("referredBy_id = ?", veh.customer.id)

        # Qual
        if veh.qualification_id
            @qualification = Qualification.find(veh.qualification_id)
        else
            @qualification = nil
        end
        prepCylinders(@qualification, 10)

        # Misc
        dom = @vehicle.date_of_manufacture
	domInt = dom.to_i
        @contractExpires = Time.local(domInt + 15)
        daysLeft = ((@contractExpires - Time.now) / spd).to_i
        daysLeft = 0  if daysLeft < 0
        @yearsTo15 = (daysLeft / 365).to_i
        @daysTo15 = daysLeft - (@yearsTo15 * 365)
        
    end


end
