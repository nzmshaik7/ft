class EmployeesController < ApplicationController

    before_filter :only_allow_admins

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

    # GET /employees/1/edit
    def edit
        @employee = Employee.find(params[:id])
        prepFormVariables
    end

    # POST /employees
    # POST /employees.json
    def create
        @employee = Employee.new(params[:employee])

        respond_to do |format|
            if @employee.save
                format.html { redirect_to employees_url,
                              notice: 'Employee was successfully created.' }
                format.json { render json: @employee, status: :created, location: @employee }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @employee.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /employees/1
    # PUT /employees/1.json
    def update
        @employee = Employee.find(params[:id])

        respond_to do |format|
            if @employee.update_attributes(params[:employee])
                format.html { redirect_to employees_url,
                              notice: 'Employee was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @employee.errors, status: :unprocessable_entity }
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
