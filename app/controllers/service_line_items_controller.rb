class ServiceLineItemsController < ApplicationController

    before_filter :only_allow_admins
    include ServiceLineItemsHelper

    def prepFormVariables(sli)
        @serviceVisits = ServiceVisit.all
        @serviceVisitCollect = @serviceVisits.collect { |p|
            [ p.visitText, p.id ] 
        }
        @technicians = Technician.all
        @technicianCollect = @technicians.collect { |p|
            [ p.employee.nameText, p.id ] 
        }
        @serviceDescriptions = ServiceDescription.all
        @serviceDescriptionCollect = @serviceDescriptions.collect { |p|
            [ p.name, p.id ] 
        }

        # Had to do this to fix Technician/string error.
        @selTech1 = 0
        @selTech2 = 0
        @selTech3 = 0
        if sli
            @selTech1 = sli.technician1_id  if sli.technician1_id
            @selTech2 = sli.technician2_id  if sli.technician2_id
            @selTech3 = sli.technician3_id  if sli.technician3_id
        end
        @technicianOptions = [
            [ "Select",   0  ],
        ]
        for tc in @technicians
            @technicianOptions.push([ tc.employee.nameText, tc.id ])
        end

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

        @technicianOptions.push([ "Unknown",  0 ])
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

    # GET /service_line_items/1
    # GET /service_line_items/1.json
    def show
        @service_line_item = ServiceLineItem.find(params[:id])
        prepFormVariables(@service_line_item)

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

    # GET /service_line_items/1/edit
    def edit
        @service_line_item = ServiceLineItem.find(params[:id])
        prepFormVariables(@service_line_item)
    end


    # Manually put in the techician IDs from the form. (update_attributes
    # stumbles.)
    #
    def setTechnicians(sli)
        if params[:technician1]
            sli.technician1_id = params[:technician1].to_i
        end
        if params[:technician2]
            sli.technician2_id = params[:technician2].to_i
        end
        if params[:technician3]
            sli.technician3_id = params[:technician3].to_i
        end
    end


    # POST /service_line_items
    # POST /service_line_items.json
    def create
        @service_line_item = ServiceLineItem.new(params[:service_line_item])
        setTechnicians(@service_line_item)

        respond_to do |format|
            if @service_line_item.save
                format.html { redirect_to service_line_items_url,
                              notice: 'ServiceLineItem was successfully created.' }
                format.json { render json: @service_line_item, status: :created, location: @service_line_item }
            else
                prepFormVariables(@service_line_item)
                format.html { render action: "new" }
                format.json { render json: @service_line_item.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_line_items/1
    # PUT /service_line_items/1.json
    def update
        @service_line_item = ServiceLineItem.find(params[:id])
        setTechnicians(@service_line_item)

        respond_to do |format|
            if @service_line_item.update_attributes(params[:service_line_item])
                format.html { redirect_to service_line_items_url,
                              notice: 'ServiceLineItem was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@service_line_item)
                format.html { render action: "edit" }
                format.json { render json: @service_line_item.errors, status: :unprocessable_entity }
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
