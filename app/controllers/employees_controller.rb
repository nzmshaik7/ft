class EmployeesController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit, ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, ]
    include ApplicationHelper


    def prepFormVariables
        @stores = Store.all
        @storeCollect = @stores.collect { |p|
            [ p.number + '/' + p.name, p.id ] 
        }
    end


    # GET /employees
    # GET /employees.json
    def index
        @employees = Employee.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @employees }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /employees/1
    # GET /employees/1.json
    def show
        @employee = Employee.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @employee }
        end
    end


    # GET /employees/new
    # GET /employees/new.json
    def new
        @employee = Employee.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @employee }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /employees/1/edit
    def edit
        @employee = Employee.find(params[:id])
        prepFormVariables
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validateEmployee?(emp)
        ok = true

        emp.first_name.strip!  if emp.first_name
        if emp.first_name.nil? or emp.first_name == ''
            ok = false
            addSessionError('First name is required field.')
        end
        emp.last_name.strip!  if emp.last_name
        if emp.last_name.nil? or emp.last_name == ''
            ok = false
            addSessionError('Last name is required field.')
        end
        emp.ssn.strip!  if emp.ssn

        if emp.store_id.nil?
            ok = false
            addSessionError('You must select a store.')
        end

        return ok
    end


    # POST /employees
    # POST /employees.json
    def create
        @employee = Employee.new(params[:employee])
        ok = validateEmployee?(@employee)
        okUrl, errAction = setSaveAction('new', employees_url)

        respond_to do |format|
            if ok and @employee.save
                format.html { redirect_to okUrl,
                              notice: 'Employee was successfully created.' }
                format.json { render json: @employee, status: :created,
                                     location: @employee }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @employee.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /employees/1
    # PUT /employees/1.json
    def update
        @employee = Employee.find(params[:id])

        respond_to do |format|
            @employee.assign_attributes(params[:employee])
            parok = validateEmployee?(@employee)
            okUrl, errAction = setSaveAction('edit', employees_url)
            saveok = false
            if parok
                saveok = @employee.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                              notice: 'Employee was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @employee.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /employees/1
    # DELETE /employees/1.json
    def destroy
        @employee = Employee.find(params[:id])
        @employee.destroy

        respond_to do |format|
            format.html { redirect_to employees_url }
            format.json { head :no_content }
        end
    end
end
