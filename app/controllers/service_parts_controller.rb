class ServicePartsController < ApplicationController

    before_filter :database_area, :except => [:gfnew_for_sli, :gfedit_for_sp, ]
    before_filter :gf_area,       :only   => [:gfnew_for_sli, :gfedit_for_sp, ]
    include ApplicationHelper

    def prepFormVariables
        @serviceLineItems = ServiceLineItem.all
        @serviceLineItemCollect = @serviceLineItems.collect { |p|
            [ p.id.to_s + ':' + p.descText, p.id ] 
        }
        @parts = Part.all
        @partCollect = @parts.collect { |p|
            if p.description and p.description.strip.length > 1
                [ p.id.to_s + ':' + p.part_name.name + '-' + 
                                    p.description[0..20], p.id ] 
            else
                [ p.id.to_s + ':' + p.part_name.name, p.id ] 
            end
        }
    end


    # GET /service_parts
    # GET /service_parts.json
    def index
        @service_parts = ServicePart.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_parts }
        end
    end


    # GET /service_parts/1
    # GET /service_parts/1.json
    def show
        @service_part = ServicePart.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_part }
        end
    end


    # GET /service_parts/new
    # GET /service_parts/new.json
    def new
        @service_part = ServicePart.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_part }
        end
    end


    # GET /service_parts/sp_for_sli/:id"
    # Create a new service part for a given service line item
    #
    def sp_for_sli
        @service_line_item = ServiceLineItem.find(params[:id])
        new
    end


    # ID in the URL is for the SLI.
    #
    def gfnew_for_sli
        sp_for_sli
    end


    # Note:  if we are EDITing a part, then the part already exists,
    # and the ID in the URL is for the part, not the SLI.
    #
    def gfedit_for_sp
        @service_part = ServicePart.find(params[:id])
        @service_line_item = @service_part.service_line_item
        prepFormVariables
    end


    # GET /service_parts/1/edit
    def edit
        @service_part = ServicePart.find(params[:id])
        prepFormVariables
    end
    
    
    def validateServicePart?(sp)
        ok = true

        if sp.quantity.nil?
            ok = false
            addSessionError('Quantity is required')
        end
        if sp.part.nil?
            ok = false
            addSessionError('You must select a Part')
        end
        if sp.part_retail_price.nil?
            ok = false
            addSessionError('You must enter a retail price')
        end
        if sp.part_actual_price.nil?
            ok = false
            addSessionError('You must enter an actual price')
        end

        return ok
    end


    # POST /service_parts
    # POST /service_parts.json
    def create
        @service_part = ServicePart.new(params[:service_part])
        ok = validateServicePart?(@service_part)
        okUrl, errAction = setSaveAction('new', service_parts_url)
        successMsg = 'Service Part was successfully created.'
        if params[:returnToSv]
            errAction = 'gfnew_for_sli'
            svid = @service_part.service_line_item.service_visit_id
            okUrl = "/service_visits/gfedit2/#{ svid }"
            successMsg = 'Service Part was successfully added.'
        end

        respond_to do |format|
            if ok and @service_part.save
                format.html { redirect_to okUrl, notice: successMsg }
                format.json { render json: @service_part, status: :created,
                              location: @service_part }
            else
                prepFormVariables
                @service_line_item = @service_part.service_line_item
                if params[:returnToSv]
                    @colorZone = 'GF'  # render loses URL
                end
                format.html { render action: errAction }
                format.json { render json: @service_part.errors,
                              status: :unprocessable_entity }
            end
        end
    end


    # PUT /service_parts/1
    # PUT /service_parts/1.json
    def update
        @service_part = ServicePart.find(params[:id])

        respond_to do |format|
            @service_part.assign_attributes(params[:service_part])
            parok = validateServicePart?(@service_part)
            okUrl, errAction = setSaveAction('edit', service_parts_url)
            if params[:returnToSv] or params[:editToSv]
                svid = @service_part.service_line_item.service_visit_id
                okUrl = "/service_visits/gfedit2/#{ svid }"
                errAction = 'gfedit_for_sp'
            end
            saveok = false
            if parok
                saveok = @service_part.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                              notice: 'ServicePart was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                @service_line_item = @service_part.service_line_item
                if params[:returnToSv] or params[:editToSv]
                    @colorZone = 'GF'  # render loses URL
                end
                format.html { render action: errAction }
                format.json { render json: @service_part.errors,
                              status: :unprocessable_entity }
            end
        end
    end


    # DELETE /service_parts/1
    # DELETE /service_parts/1.json
    def destroy
        @service_part = ServicePart.find(params[:id])
        @service_part.destroy

        respond_to do |format|
            format.html { redirect_to service_parts_url }
            format.json { head :no_content }
        end
    end


    def gfdelete_for_sp
        @service_part = ServicePart.find(params[:id])
        svid = @service_part.service_line_item.service_visit_id
        okUrl = "/service_visits/gfedit2/#{ svid }"
        @service_part.destroy

        respond_to do |format|
            format.html { redirect_to okUrl }
            format.json { head :no_content }
        end
    end

end
