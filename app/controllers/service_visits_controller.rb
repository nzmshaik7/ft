class ServiceVisitsController < ApplicationController

    before_filter :database_area, :except => [:gfindex, :gfedit2, :gfshow,
                                              :gfsearch1, :gfmatch1, 
                                              :gfnew0, :gfnew1, :gfnew2,
                                              ]
    before_filter :gf_area,       :only   => [:gfindex, :gfedit2, :gfshow,
                                              :gfsearch1, :gfmatch1, 
                                              :gfnew0, :gfnew1, :gfnew2,
                                              ]
    include CustomersHelper
    include ApplicationHelper
    include ServiceLineItemsHelper


    def prepFormVariables(sv=nil)
        @stores = Store.all
        @storeCollect = @stores.collect { |p|
            [ p.number + '/' + p.name, p.id ] 
        }
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ] 
        }
        @invoices = Invoice.all
        @invoiceCollect = @invoices.collect { |p|
            [ p.invoice_number, p.id ] 
        }
        @salespersons = Salesperson.all
        @salespersonCollect = @salespersons.collect { |p|
            [ p.employee.nameText, p.id ] 
        }
        @statusOptions = ServiceVisit::STATUS_OPTIONS
        @selStatus = 0
        if sv
            if sv.statusValid?
                @selStatus = sv.status
            end
        end
    end


    def prepSliVariables(sli=nil)
        @serviceDescriptions = ServiceDescription.find(:all, :order => 'name')
        @serviceDescriptionCollect = @serviceDescriptions.collect { |p|
            [ p.name, p.id ] 
        }

        @selStype = 0
        if sli   # Currently always false
            if sli.stypeIsValid
                @selStype = sli.stype
            end
        end
        @stypeOptions = Array.new
        @stypeOptions.push(['Select', 0])
        for st in ServiceLineItem::S_QUALIFICATION .. ServiceLineItem::S_OTHER
            @stypeOptions.push([stypeText(st), st])
        end

        @technicians = Technician.all
        @selTech = 0
	@technicianOptions = [
	    [ "Select",   0  ],
	]
	for tc in @technicians
	    @technicianOptions.push([ tc.employee.nameText, tc.id ])
	end

        @partCollect = [
	    [ "Select",   0  ],
        ]
        @parts = Part.find(:all, :order => 'part_number')
        for p in @parts
            @partCollect.push([ p.part_name.name + '-' + 
                        p.part_manufacturer.name + ':' + p.part_number, p.id ])
        end
    end



    # GET /service_visits
    # GET /service_visits.json
    def index
        @service_visits = ServiceVisit.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_visits }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /service_visits/1
    # GET /service_visits/1.json
    def show
        @service_visit = ServiceVisit.find(params[:id])
        prepFormVariables(@service_visit)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_visit }
        end
    end


    def gfshow
        show
    end


    # GET /service_visits/new
    # GET /service_visits/new.json
    def new
        @service_visit = ServiceVisit.new
        prepFormVariables(@service_visit)

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_visit }
        end
    end


    def gfnew0
    end


    def gfnew1
        @vehicle = Vehicle.find(params[:id])
        prepSliVariables
        new
    end


    def validateServiceVisit?(sv)
        ok = true
        if not sv.statusValid?
            ok = false
            addSessionError('You must select a status for the service visit.')
        end
        if sv.mileage.nil? or sv.mileage < 1
            ok = false
            addSessionError('You must enter a current mileage for this visit.')
        end
        if sv.store_id.nil? or sv.store_id == 0
            ok = false
            addSessionError('You must select a store for this visit.')
        end
        return ok
    end


    def validateSvPlus?(sv)
        ok = validateServiceVisit?(sv)
        @new_sli = makeNewSli
        ok = false  if @new_sli.nil?

        thok, @new_ths = makeNewTechHours
        ok = false  if not thok

        spok, @new_sparts = makeNewServiceParts
        ok = false  if not spok

        return ok
    end
    
    
    def makeNewServiceParts
        ok = true
        parsp = params[:service_part]
        if parsp.nil?
            addSessionError('INTERNAL ERROR: no service parts')
            return false, nil
        end
        sps = Array.new()
        for pdex in 1..99
            pkeyid = "part_id_#{pdex}"
            if not parsp.has_key?(pkeyid)
                break
            end

            sp = ServicePart.new
            keyid = "quantity_#{pdex}"
            sp.quantity = parsp[keyid].to_i
            keyid = "part_retail_price_#{pdex}"
            sp.part_retail_price = parsp[keyid].to_f
            keyid = "part_actual_price_#{pdex}"
            sp.part_actual_price = parsp[keyid].to_f

            # All or nothing
            if parsp[pkeyid].nil? or parsp[pkeyid].to_i == 0
                if sp.part_retail_price > 0 or sp.part_actual_price > 0
                    addSessionError("You must select a Part if you" +
                                    "enter a part price.")
                    ok = false
                else  # This one is blank
                    next
                end
            else  # part is selected
                sp.part_id = parsp[pkeyid].to_i
                partSearched = false

                keyid = "part_retail_price_#{pdex}"
                if parsp[keyid].nil? or parsp[keyid].strip == ''
                    part = Part.where("id = ?", sp.part_id).first
                    partSearched = true
                    if part.nil?
                        addSessionError("INTERNAL ERROR: part " +
                                        "#{sp.part_id} not found")
                        return false, nil
                    end
                    sp.part_retail_price = part.retail_price
                else
                    sp.part_retail_price = parsp[keyid].to_f
                end

                keyid = "part_actual_price_#{pdex}"
                if parsp[keyid].nil? or parsp[keyid].strip == ''
                    if not partSearched
                        part = Part.where("id = ?", sp.part_id).first
                        if part.nil?
                            addSessionError("INTERNAL ERROR: part " +
                                            "#{sp.part_id} not found")
                            return false, nil
                        end
                    end
                    sp.part_actual_price = part.actual_cost
                else
                    sp.part_actual_price = parsp[keyid].to_f
                end

                sps.push(sp)
            end
        end
        return ok, sps
    end
    
    
    def makeNewTechHours
        ok = true
        parth = params[:technician_hour]
        if parth.nil?
            addSessionError('INTERNAL ERROR: no technician hours')
            return false, nil
        end
        ths = Array.new()
        for tdex in 1..99
            tkeyid = "technician_id_#{tdex}"
            if not parth.has_key?(tkeyid)
                break
            end

            th = TechnicianHour.new
            keyid = "labor_hours_retail_#{tdex}"
            th.labor_hours_retail = parth[keyid].to_i
            keyid = "labor_rate_retail_#{tdex}"
            th.labor_rate_retail = parth[keyid].to_f
            keyid = "labor_hours_actual_#{tdex}"
            th.labor_hours_actual = parth[keyid].to_i

            # All or nothing
            if parth[tkeyid].nil? or parth[tkeyid].to_i == 0
                if th.labor_hours_retail > 0 or th.labor_hours_actual > 0
                    addSessionError("You must select a Technician if you" +
                                    "enter hours.")
                    ok = false
                else  # This one is blank
                    next
                end
            else  # tech is selected
                if th.labor_hours_retail == 0 and th.labor_hours_actual == 0
                    addSessionError("You must enter hours if you select " +
                                    "a Technician.")
                    ok = false
                    next
                end
                th.technician_id = parth[tkeyid].to_i

                keyid = "labor_rate_actual_#{tdex}"
                if parth[keyid].nil? or parth[keyid].strip == ''
                    tech = Technician.where("id = ?", th.technician_id).first
                    if tech.nil?
                        addSessionError("INTERNAL ERROR: technician " +
                                        "#{th.technician_id} not found")
                        return false, nil
                    end
                    th.labor_rate_actual = tech.hourly_rate
                else
                    th.labor_rate_actual = parth[keyid].to_f
                end

                ths.push(th)
            end
        end
        return ok, ths
    end


    def makeNewSli
        ok = true
        sli = ServiceLineItem.new()
        parsli = params[:service_line_item]
        if parsli.nil?
            addSessionError('INTERNAL ERROR: no service_line_item')
            return nil
        end

        sli.service_description_id = parsli[:service_description_id].to_i
        if sli.service_description_id.nil? or sli.service_description_id == 0
            ok = false
            addSessionError('You must select a service line item Service ' +
                            'Description.')
        end

        sli.stype = parsli[:stype].to_i
        if sli.stype.nil? or sli.stype == 0
            ok = false
            addSessionError('You must select a service line item Type.')
        end

        sli.service_description_text = parsli[:service_description_text]

        return sli  if ok
        return nil
    end


    # By this time, we are commited to save/create the service visit
    # and all its subcomponents.  save makes the ids valid.  
    #
    def saveAndUpdateSvIds(sv, new_sli, new_ths, new_sparts)
        ok = sv.save
        return false if not ok

        new_sli.service_visit_id = sv.id
        ok = new_sli.save
        return false if not ok

        for th in new_ths 
            th.service_line_item_id = new_sli.id
            ok = th.save
            return false if not ok
        end

        for sp in new_sparts
            sp.service_line_item_id = new_sli.id
            ok = sp.save
            return false if not ok
        end

        return true
    end


    # Create a new service visit along with its supporting objects.
    # Create only adds 1 service line item initially.
    #
    def gfnew2
        @service_visit = ServiceVisit.new(params[:service_visit])
        ok = validateSvPlus?(@service_visit)

        if ok 
            ok = saveAndUpdateSvIds(@service_visit, @new_sli, @new_ths,
                                                              @new_sparts)
        end
        if ok 
            flash[:notice] = 'Service Visit successfully created.'
            redirect_to action: 'gfindex'
        else
            prepFormVariables
            prepSliVariables
            svpar = params[:service_visit]
            if svpar.has_key?('vehicle_id')
                @vehicle = Vehicle.find(svpar[:vehicle_id])
            end
            render action: 'gfnew1'
        end
    end


    # GET /service_visits/1/edit
    def edit
        @service_visit = ServiceVisit.find(params[:id])
        prepFormVariables(@service_visit)
    end


    def gfedit2
        @isGroundFloor = true
        edit
    end


    # POST /service_visits
    # POST /service_visits.json
    def create
        @service_visit = ServiceVisit.new(params[:service_visit])

        respond_to do |format|
            if @service_visit.save
                format.html { redirect_to service_visits_url,
                              notice: 'ServiceVisit was successfully created.' }
                format.json { render json: @service_visit, status: :created,
                                     location: @service_visit }
            else
                prepFormVariables(@service_visit)
                format.html { render action: "new" }
                format.json { render json: @service_visit.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /service_visits/1
    # PUT /service_visits/1.json
    def update
        @service_visit = ServiceVisit.find(params[:id])

        respond_to do |format|
            if @service_visit.update_attributes(params[:service_visit])
                format.html { redirect_to service_visits_url,
                              notice: 'ServiceVisit was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@service_visit)
                format.html { render action: "edit" }
                format.json { render json: @service_visit.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /service_visits/1
    # DELETE /service_visits/1.json
    def destroy
        @service_visit = ServiceVisit.find(params[:id])
        @service_visit.destroy

        respond_to do |format|
            format.html { redirect_to service_visits_url }
            format.json { head :no_content }
        end
    end
end
