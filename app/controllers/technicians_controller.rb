class TechniciansController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit,
                                              :update, :create, ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit,
                                              :update, :create, ]
    include ApplicationHelper

    def prepFormVariables
        @employees = Employee.all
        @employeeCollect = @employees.collect { |p|
            [ p.nameText, p.id ] 
        }
    end


    # GET /technicians
    # GET /technicians.json
    def index
        @technicians = Technician.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @technicians }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /technicians/1
    # GET /technicians/1.json
    def show
        @technician = Technician.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @technician }
        end
    end


    # GET /technicians/new
    # GET /technicians/new.json
    def new
        @technician = Technician.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @technician }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /technicians/1/edit
    def edit
        @technician = Technician.find(params[:id])
        prepFormVariables
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validateTechnician?(tech)
        ok = true

        if tech.employee_id.nil?
            ok = false
            addSessionError('You must select an Employee.')
        end

        if tech.level.nil?
            ok = false
            addSessionError('Level is a required field.')
        end
        if tech.hourly_rate.nil? or tech.hourly_rate == 0.0
            ok = false
            addSessionError('Hourly Rate is a required field.')
        end

        return ok
    end


    def prevalidateTechnician(tech)
        ok = true
        tpar = params[:technician]
        if tpar[:employee_id] 
            newEmployeeId = tpar[:employee_id].to_i
            if newEmployeeId > 0 and tech.employee_id != newEmployeeId
                conflict = Technician.where("employee_id = ?", newEmployeeId)
                if conflict.length > 0
                    ok = false
                    msg = 'Another technician (' + 
                          conflict.first.employee.nameText +
                          ') is already that employee.'
                    addSessionError(msg)
                end
            end
        end
        return ok
    end


    # POST /technicians
    # POST /technicians.json
    def create
        @technician = Technician.new(params[:technician])
        ok = validateTechnician?(@technician)
        okUrl, errAction = setSaveAction('new', technicians_url)

        respond_to do |format|
            if ok and @technician.save
                format.html { redirect_to okUrl,
                              notice: 'Technician was successfully created.' }
                format.json { render json: @technician, status: :created,
                                     location: @technician }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @technician.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /technicians/1
    # PUT /technicians/1.json
    def update
        @technician = Technician.find(params[:id])
        preok = prevalidateTechnician(@technician)

        respond_to do |format|
            @technician.assign_attributes(params[:technician])
            parok = validateTechnician?(@technician)
            okUrl, errAction = setSaveAction('edit', technicians_url)
            saveok = false
            if parok and preok
                saveok = @technician.save
            end
            if parok and preok and saveok
                format.html { redirect_to okUrl,
                              notice: 'Technician was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @technician.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /technicians/1
    # DELETE /technicians/1.json
    def destroy
        @technician = Technician.find(params[:id])
        @technician.destroy

        respond_to do |format|
            format.html { redirect_to technicians_url }
            format.json { head :no_content }
        end
    end
end
