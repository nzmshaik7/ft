class SalespeopleController < ApplicationController
    # GET /salespeople
    # GET /salespeople.json
    def index
        @salespeople = Salesperson.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @salespeople }
        end
    end

    # GET /salespeople/1
    # GET /salespeople/1.json
    def show
        @salesperson = Salesperson.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @salesperson }
        end
    end

    # GET /salespeople/new
    # GET /salespeople/new.json
    def new
        @salesperson = Salesperson.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @salesperson }
        end
    end

    # GET /salespeople/1/edit
    def edit
        @salesperson = Salesperson.find(params[:id])
    end

    # POST /salespeople
    # POST /salespeople.json
    def create
        @salesperson = Salesperson.new(params[:salesperson])

        respond_to do |format|
            if @salesperson.save
                format.html { redirect_to @salesperson, notice: 'Salesperson was successfully created.' }
                format.json { render json: @salesperson, status: :created, location: @salesperson }
            else
                format.html { render action: "new" }
                format.json { render json: @salesperson.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /salespeople/1
    # PUT /salespeople/1.json
    def update
        @salesperson = Salesperson.find(params[:id])

        respond_to do |format|
            if @salesperson.update_attributes(params[:salesperson])
                format.html { redirect_to @salesperson, notice: 'Salesperson was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @salesperson.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /salespeople/1
    # DELETE /salespeople/1.json
    def destroy
        @salesperson = Salesperson.find(params[:id])
        @salesperson.destroy

        respond_to do |format|
            format.html { redirect_to salespeople_url }
            format.json { head :no_content }
        end
    end
end
