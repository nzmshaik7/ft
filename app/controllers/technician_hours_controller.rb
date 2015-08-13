class TechnicianHoursController < ApplicationController

    before_filter :database_area


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

    # POST /technician_hours
    # POST /technician_hours.json
    def create
        @technician_hour = TechnicianHour.new(params[:technician_hour])

        respond_to do |format|
            if @technician_hour.save
                format.html { redirect_to @technician_hour,
		          notice: 'Technician hour was successfully created.' }
                format.json { render json: @technician_hour, status: :created,
		                     location: @technician_hour }
            else
		prepFormVariables(@technician_hour)
                format.html { render action: "new" }
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
            if @technician_hour.update_attributes(params[:technician_hour])
                format.html { redirect_to @technician_hour,
		         notice: 'Technician hour was successfully updated.' }
                format.json { head :no_content }
            else
		prepFormVariables(@technician_hour)
                format.html { render action: "edit" }
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
end
