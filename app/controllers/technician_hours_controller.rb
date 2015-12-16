class TechnicianHoursController < ApplicationController

    before_filter :database_area, :except => [:gfnew_for_sli, :gfedit_for_th, ]
    before_filter :gf_area,       :only   => [:gfnew_for_sli, :gfedit_for_th, ]
    include ApplicationHelper


    def prepFormVariables(th)
        @technicians = Technician.all
        @selTech = 0
	if th and th.technician
	    # logger.info("==== th id is #{th.id}")
	    @selTech = th.technician.id
	end
	@technicianOptions = [
	    [ "Select",   0  ],
	]
	for tc in @technicians
	    @technicianOptions.push([ tc.employee.nameText, tc.id ])
	end
    end


    # GET /technician_hours
    # GET /technician_hours.json
    def index
        @technician_hours = TechnicianHour.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @technician_hours }
        end
    end


    # GET /technician_hours/1
    # GET /technician_hours/1.json
    def show
        @technician_hour = TechnicianHour.find(params[:id])
        prepFormVariables(@technician_hour)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @technician_hour }
        end
    end


    # GET /technician_hours/new
    # GET /technician_hours/new.json
    def new
        @technician_hour = TechnicianHour.new
        prepFormVariables(@technician_hour)

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @technician_hour }
        end
    end


    # ID in the URL is for the SLI.
    #
    def gfnew_for_sli
        @service_line_item = ServiceLineItem.find(params[:id])
        new
    end


    # Note:  if we are EDITing a tech hour, then the tech hour already exists,
    # and the ID in the URL is for the tech hour, not the SLI.
    #
    def gfedit_for_th
        edit
        @service_line_item = @technician_hour.service_line_item
    end


    # GET /technician_hours/th_for_sli/:id"
    # Create a new technician hours record for a given service line item
    #
    def th_for_sli
        @service_line_item = ServiceLineItem.find(params[:id])
        new
    end


    # GET /technician_hours/1/edit
    def edit
        @technician_hour = TechnicianHour.find(params[:id])
        prepFormVariables(@technician_hour)
    end
    
    
    def validateTechnicianHour?(th)
        ok = true

        if th.labor_hours_retail.nil?
            ok = false
            addSessionError('Labor hours retail is required')
        end
        if th.labor_rate_retail.nil?
            ok = false
            addSessionError('Labor rate retail is required')
        end
        if th.labor_hours_actual.nil?
            ok = false
            addSessionError('Labor hours actual is required')
        end
        if th.technician.nil?
            ok = false
            addSessionError('You must select a Technician')
        else
            if th.labor_rate_actual.nil?
                th.labor_rate_actual = th.technician.hourly_rate
            end
        end

        return ok
    end


    # POST /technician_hours
    # POST /technician_hours.json
    def create
        @technician_hour = TechnicianHour.new(params[:technician_hour])
        ok = validateTechnicianHour?(@technician_hour)
        okUrl, errAction = setSaveAction('new', technician_hours_url)
        successMsg = 'Technician Hours was successfully created.'
        if params[:returnToSv]
            errAction = 'gfnew_for_sli'
            svid = @technician_hour.service_line_item.service_visit_id
            okUrl = "/service_visits/gfedit2/#{ svid }"
            successMsg = 'Technicial Hours were successfully added.'
        end

        respond_to do |format|
            if ok and @technician_hour.save
                format.html { redirect_to okUrl, notice: successMsg }
                format.json { render json: @technician_hour, status: :created,
		                     location: @technician_hour }
            else
		prepFormVariables(@technician_hour)
                @service_line_item = @technician_hour.service_line_item
                if params[:returnToSv]
                    @colorZone = 'GF'  # render loses URL
                end
                format.html { render action: errAction }
                format.json { render json: @technician_hour.errors,
		                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /technician_hours/1
    # PUT /technician_hours/1.json
    def update
        @technician_hour = TechnicianHour.find(params[:id])

        respond_to do |format|
            @technician_hour.assign_attributes(params[:technician_hour])
            parok = validateTechnicianHour?(@technician_hour)
            okUrl, errAction = setSaveAction('edit', technician_hours_url)
            if params[:returnToSv] or params[:editToSv]
                svid = @technician_hour.service_line_item.service_visit_id
                okUrl = "/service_visits/gfedit2/#{ svid }"
                errAction = 'gfedit_for_th'
            end
            saveok = false
            if parok
                saveok = @technician_hour.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
		         notice: 'Technician hours were successfully updated.' }
                format.json { head :no_content }
            else
		prepFormVariables(@technician_hour)
                @service_line_item = @technician_hour.service_line_item
                if params[:returnToSv] or params[:editToSv]
                    @colorZone = 'GF'  # render loses URL
                end
                format.html { render action: errAction }
                format.json { render json: @technician_hour.errors,
		                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /technician_hours/1
    # DELETE /technician_hours/1.json
    def destroy
        @technician_hour = TechnicianHour.find(params[:id])
        @technician_hour.destroy

        respond_to do |format|
            format.html { redirect_to technician_hours_url }
            format.json { head :no_content }
        end
    end


    def gfdelete_for_th
        @technician_hour = TechnicianHour.find(params[:id])
        svid = @technician_hour.service_line_item.service_visit_id
        okUrl = "/service_visits/gfedit2/#{ svid }"
        @technician_hour.destroy

        respond_to do |format|
            format.html { redirect_to okUrl }
            format.json { head :no_content }
        end
    end

end
