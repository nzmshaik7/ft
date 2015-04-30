class ContractsController < ApplicationController

    before_filter :only_allow_admins

    def prepFormVariables(contract)

        # @vehicles will be used later.
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ] 
        }

        @salespersons = Salesperson.all
        @salespersonCollect = @salespersons.collect { |p|
            [ p.employee.nameText, p.id ] 
        }

        @selStatus = 0
        if contract
            if [Contract::STATUS_CURRENT, Contract::STATUS_LAPSED, 
                Contract::STATUS_CANCELLED].include?(contract.status)
                @selStatus = contract.status
            end
        end
        @statusOptions = [
            [ "Select",      0  ],
            [ "Current",     51 ],
            [ "Lapsed",      52 ],
            [ "Cancelled",   53 ],
        ]
    end

    # GET /contracts
    # GET /contracts.json
    def index
        @contracts = Contract.all
        prepFormVariables(@contract)

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @contracts }
        end
    end

    # GET /contracts/1
    # GET /contracts/1.json
    def show
        @contract = Contract.find(params[:id])
        prepFormVariables(@contract)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @contract }
        end
    end

    # GET /contracts/new
    # GET /contracts/new.json
    def new
        @contract = Contract.new
        prepFormVariables(@contract)

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @contract }
        end
    end

    # GET /contracts/1/edit
    def edit
        @contract = Contract.find(params[:id])
        prepFormVariables(@contract)
    end

    # POST /contracts
    # POST /contracts.json
    def create
        @contract = Contract.new(params[:contract])
        @contract.discount = 0.0  if @contract.discount.nil?
        @contract.discount_percent = 0  if @contract.discount_percent.nil?

        respond_to do |format|
            if @contract.save
                format.html { redirect_to contracts_url,
                              notice: 'Contract was successfully created.' }
                format.json { render json: @contract, status: :created, location: @contract }
            else
                prepFormVariables(@contract)
                format.html { render action: "new" }
                format.json { render json: @contract.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /contracts/1
    # PUT /contracts/1.json
    def update
        @contract = Contract.find(params[:id])

        respond_to do |format|
            if @contract.update_attributes(params[:contract])
                format.html { redirect_to contracts_url,
                              notice: 'Contract was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@contract)
                format.html { render action: "edit" }
                format.json { render json: @contract.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /contracts/1
    # DELETE /contracts/1.json
    def destroy
        @contract = Contract.find(params[:id])
        @contract.destroy

        respond_to do |format|
            format.html { redirect_to contracts_url }
            format.json { head :no_content }
        end
    end
end
