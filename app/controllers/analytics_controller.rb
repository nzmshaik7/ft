class AnalyticsController < ApplicationController

    before_filter :only_allow_admins
    include CustomersHelper
    include QualificationsHelper
    include ServiceLineItemsHelper

    def prepFormVariables(veh)
        now = Time.now

        @monthsCollect = Array.new
        for mn in 1 .. 12
            mtime = Time.local(2000, mn, 15, 1, 1, 1)
            @monthsCollect.push([ mtime.strftime("%b"), mtime.mon ])
        end
        @selStMonth = 1
        @selEnMonth = 12

        @daysCollect = Array.new
        for dy in 1 .. 31
            @daysCollect.push([ dy, dy ])
        end
        @selStDay = 1
        @selEnDay = 1

        @yearsCollect = Array.new
        thisYear = Time.now.year
        for yr in thisYear - 15 .. thisYear
            @yearsCollect.push([ yr, yr ])
        end
        @selStYear = thisYear
        @selEnYear = thisYear

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
        @membIncome = 0.0
        @membLaborActual = 0.0
        @membPartsActual = 0.0
        @notCoveredIncome = 0.0
        @notCoveredLaborActual = 0.0
        @notCoveredPartsActual = 0.0
        @otherIncome = 0.0
        @otherLaborActual = 0.0
        @otherPartsActual = 0.0
        for svisit in veh.service_visits
            for sli in svisit.service_line_items
		setTotalsForSvcLineItem(sli)
                if sli.stype == ServiceLineItem::S_QUALIFICATION
                    @qualRetail += @totLaborRetail
                    @qualLaborActual += @totLaborActual
                    for sp in sli.service_parts
                        @qualRetail += sp.part_retail_price
                        @qualPartsActual += sp.part_actual_price
                    end
                elsif sli.stype == ServiceLineItem::S_MEMB_SERVICE
                    @membLaborActual += @totLaborActual
                    for sp in sli.service_parts
                        @membPartsActual += sp.part_actual_price
                    end
                elsif sli.stype == ServiceLineItem::S_MEMB_REPAIR
                    @membLaborActual += @totLaborActual
                    for sp in sli.service_parts
                        @membPartsActual += sp.part_actual_price
                    end
                elsif sli.stype == ServiceLineItem::S_MEMB_NOT_COVERED
                    @notCoveredIncome += @totLaborRetail
                    @notCoveredLaborActual += @totLaborActual
                    for sp in sli.service_parts
                        @notCoveredIncome += sp.part_retail_price
                        @notCoveredPartsActual += sp.part_actual_price
                    end
                else
                    @otherIncome += @totLaborRetail
                    @otherLaborActual += @totLaborActual
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
            end
        end

        @totalIncome = @qualRetail + @membIncome + @notCoveredIncome
        @totalCost = @qualLaborActual + @qualPartsActual +
                     @membLaborActual + @membPartsActual +
                     @notCoveredLaborActual + @notCoveredPartsActual
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

    
    # GET analytics/int1/:id
    def int1
        @vehicle = Vehicle.find(params[:id])
        prepFormVariables(@vehicle)
        calcProfitLoss(@vehicle)
        calcInternal1(@vehicle)
        calcFinanceAgreements(@vehicle)
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
        for s_visit in veh.service_visits
            if oldestMileageTime.nil? or s_visit.sdate < oldestMileageTime
                oldestMileageTime = s_visit.sdate
                oldestMileage = s_visit.mileage
            end
            if newestMileageTime.nil? or s_visit.sdate > newestMileageTime
                newestMileageTime = s_visit.sdate
                newestMileage = s_visit.mileage
            end
        end
        @avgMilesPerYear = nil
        if oldestMileageTime
            daySpan = (newestMileageTime.to_i - oldestMileageTime.to_i) / spd
            if daySpan > 30.0
                yearSpan = daySpan / 365.2425
                @avgMilesPerYear = (newestMileage - oldestMileage) / yearSpan
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
