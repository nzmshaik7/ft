class AnalyticsController < ApplicationController

    before_filter :database_area
    include CustomersHelper
    include QualificationsHelper
    include ServiceLineItemsHelper
    include ApplicationHelper

    def prepFormVariables(veh)
        now = Time.now
        prepDateCollects

        @custDays = (((Time.now - veh.customer.joined_date) / 3600) / 24).to_i
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

    
    # GET analytics/int1/:id
    def int1
        @vehicle = Vehicle.find(params[:id])
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
        @contractExpires = Time.local(dom.year + 15, dom.month, dom.day, 
                                      dom.hour, dom.min, dom.sec)
        daysLeft = ((@contractExpires - Time.now) / spd).to_i
        daysLeft = 0  if daysLeft < 0
        @yearsTo15 = (daysLeft / 365).to_i
        @daysTo15 = daysLeft - (@yearsTo15 * 365)
        
    end


end
