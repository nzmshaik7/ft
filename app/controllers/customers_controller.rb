class CustomersController < ApplicationController

    before_filter :only_allow_admins
    include CustomersHelper

    def prepFormVariables(customer=nil)
        @states = State.all
        @stateCollect = @states.collect { |p|
            [ p.name, p.id ] 
        }

        @users = User.all
        @userCollect = @users.collect { |p|
            [ p.first_name + ' ' + p.last_name, p.id ] 
        }

        @customers = Customer.all
        @customerCollect = @customers.collect { |p|
            [ customerName2(p), p.id ] 
        }

        @stores = Store.all
        @storeCollect = @stores.collect { |p|
            [ p.number + '/' + p.name, p.id ] 
        }

        @referredBys = ReferredBy.all
        @referredByCollect = @referredBys.collect { |p|
            [ p.description, p.id ] 
        }

        @selGender = 1
        if customer
            if [Customer::GENDER_MALE, Customer::GENDER_FEMALE,
                Customer::GENDER_OTHER].include?(customer.gender)
                @selStatus = customer.gender
            end
        end
        @genderOptions = [
            [ "Select",   0  ],
            [ "Male",     Customer::GENDER_MALE ],
            [ "Female",   Customer::GENDER_FEMALE ],
            [ "Other",    Customer::GENDER_OTHER ],
            [ "Unknown",  0 ],
        ]
    end

    # GET /customers
    # GET /customers.json
    def index
        @customers = Customer.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @customers }
        end
    end

    # GET /customers/1
    # GET /customers/1.json
    def show
        @customer = Customer.find(params[:id])
        prepFormVariables(@customer)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @customer }
        end
    end

    # GET /customers/new
    # GET /customers/new.json
    def new
        @customer = Customer.new
        prepFormVariables(@customer)

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @customer }
        end
    end

    # GET /customers/1/edit
    def edit
        @customer = Customer.find(params[:id])
        prepFormVariables(@customer)
    end

    # POST /customers
    # POST /customers.json
    def create
        @customer = Customer.new(params[:customer])

        respond_to do |format|
            if @customer.save
                format.html { redirect_to customers_url,
                              notice: 'Customer was successfully created.' }
                format.json { render json: @customer, status: :created, location: @customer }
            else
                prepFormVariables(@customer)
                format.html { render action: "new" }
                format.json { render json: @customer.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /customers/1
    # PUT /customers/1.json
    def update
        @customer = Customer.find(params[:id])

        respond_to do |format|
            if @customer.update_attributes(params[:customer])
                format.html { redirect_to customers_url,
                              notice: 'Customer was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@customer)
                format.html { render action: "edit" }
                format.json { render json: @customer.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /customers/1
    # DELETE /customers/1.json
    def destroy
        @customer = Customer.find(params[:id])
        @customer.destroy

        respond_to do |format|
            format.html { redirect_to customers_url }
            format.json { head :no_content }
        end
    end
end
