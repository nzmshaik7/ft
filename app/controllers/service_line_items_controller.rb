class ServiceLineItemsController < ApplicationController

    before_action :database_area, :except => [:gfnew, :gfindex, :gfedit, ]
    before_action :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, ]
    include ApplicationHelper
    include ServiceLineItemsHelper


    def prepFormVariables(sli)
        @serviceVisits = ServiceVisit.all
        @serviceVisitCollect = @serviceVisits.collect { |p|
            [ p.visitText, p.id ] 
        }
        @serviceDescriptions = ServiceDescription.all
        @serviceDescriptionCollect = @serviceDescriptions.collect { |p|
            [ p.name, p.id ] 
        }

        @selStype = 0
        if sli
            if sli.stypeIsValid
                @selStype = sli.stype
            end
        end
        @stypeOptions = Array.new
        @stypeOptions.push(['Select', 0])
        for st in ServiceLineItem::S_QUALIFICATION .. ServiceLineItem::S_OTHER
            @stypeOptions.push([stypeText(st), st])
        end

    end


    # GET /service_line_items
    # GET /service_line_items.json
    def index
        @service_line_items = ServiceLineItem.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_line_items }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /service_line_items/1
    # GET /service_line_items/1.json
    def show
        @service_line_item = ServiceLineItem.find(params[:id])
        prepFormVariables(@service_line_item)

	setTotalsForSvcLineItem(@service_line_item)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_line_item }
        end
    end


    # GET /service_line_items/new
    # GET /service_line_items/new.json
    def new
        @service_line_item = ServiceLineItem.new
        prepFormVariables(@service_line_item)

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_line_item }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /service_line_items/sli_for_visit/:id"
    # Create a new service line item for a given service visit
    #
    def sli_for_visit
        @service_visit = ServiceVisit.find(params[:id])
        new
    end


    # GET /service_line_items/1/edit
    def edit
        @service_line_item = ServiceLineItem.find(params[:id])
        prepFormVariables(@service_line_item)
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    # Manually put in the techician IDs from the form. (update_attributes
    # stumbles.)
    #
    def setTechnicians(sli)
        if params[:technician1]
            # sli.technician1_id = params[:technician1].to_i
        end
    end


    def validateServiceLineItem?(sli)
        ok = true

        sli.service_description_text.strip!  if sli.service_description_text
        if sli.service_description_text.nil? or 
                                             sli.service_description_text == ''
            if sli.service_description.nil?
                ok = false
                addSessionError('Either Service Description text or ' +
                                'selection from dropdown required.')
            end
        end

        return ok
    end


    # POST /service_line_items
    # POST /service_line_items.json
    def create
        @service_line_item = ServiceLineItem.new(params.require(:service_line_item).permit(:labor_hours_actual, :labor_hours_retail,
                    :labor_rate_actual, :labor_rate_retail,
                    :service_description_id, :service_description_text,
                    :service_visit_id, :stype))
        ok = validateServiceLineItem?(@service_line_item)
        okUrl, errAction = setSaveAction('new', service_line_items_url)
        setTechnicians(@service_line_item)

        respond_to do |format|
            if ok and @service_line_item.save
                format.html { redirect_to okUrl,
                      notice: 'Service Line Item was successfully created.' }
                format.json { render json: @service_line_item,
		                     status: :created,
				     location: @service_line_item }
            else
                prepFormVariables(@service_line_item)
                format.html { render action: errAction }
                format.json { render json: @service_line_item.errors,
		                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /service_line_items/1
    # PUT /service_line_items/1.json
    def update
        @service_line_item = ServiceLineItem.find(params[:id])
        setTechnicians(@service_line_item)

        respond_to do |format|
            @service_line_item.assign_attributes(params.require(:service_line_item).permit(:labor_hours_actual, :labor_hours_retail,
                    :labor_rate_actual, :labor_rate_retail,
                    :service_description_id, :service_description_text,
                    :service_visit_id, :stype))
            parok = validateServiceLineItem?(@service_line_item)
            okUrl, errAction = setSaveAction('edit', service_line_items_url)
            if params[:svsv]
                svid = @service_line_item.service_visit.id
                okUrl = "/service_visits/gfedit2/#{svid}"
            end
            saveok = false
            if parok
                saveok = @service_line_item.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
			 notice: 'Service Line Item was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@service_line_item)
                format.html { render action: errAction }
                format.json { render json: @service_line_item.errors,
		                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /service_line_items/1
    # DELETE /service_line_items/1.json
    def destroy
        @service_line_item = ServiceLineItem.find(params[:id])
        @service_line_item.destroy

        respond_to do |format|
            format.html { redirect_to service_line_items_url }
            format.json { head :no_content }
        end
    end

end
