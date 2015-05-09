class AnalyticsController < ApplicationController

    before_filter :only_allow_admins
    include CustomersHelper

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
        @custAge = now.year - veh.customer.date_of_birth.year
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
    end

    
    # GET analytics/int1/:id
    def int1
        @vehicle = Vehicle.find(params[:id])
        prepFormVariables(@vehicle)
        calcProfitLoss(@vehicle)
    end


end
