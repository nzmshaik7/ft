class CustomersController < ApplicationController

    before_filter :database_area, :except => [:gfnew, ]
    before_filter :gf_area, :only => [:gfnew, ]
    include CustomersHelper
    include ApplicationHelper

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
                @selGender = customer.gender
            end
        end
        @genderOptions = [
            [ "Select",   0  ],
            [ "Male",     Customer::GENDER_MALE ],
            [ "Female",   Customer::GENDER_FEMALE ],
            [ "Other",    Customer::GENDER_OTHER ],
            [ "Unknown",  0 ],
        ]

        @selContactMethod = 0
        if customer
            if [Customer::CONTACT_EMAIL, Customer::CONTACT_TEXT,
                Customer::CONTACT_CALL].include?(customer.contact_method)
                @selContactMethod = customer.contact_method
            end
        end
        @contactMethodOptions = [
            [ "Select", 0  ],
            [ "email",  Customer::CONTACT_EMAIL ],
            [ "text",   Customer::CONTACT_TEXT  ],
            [ "call",   Customer::CONTACT_CALL  ],
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


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /customers/1/edit
    def edit
        @customer = Customer.find(params[:id])
        prepFormVariables(@customer)
    end


    def validateCustomer?(cust)
        ok = true
        cust.first_name.strip!  if cust.first_name
        cust.middle_name.strip!  if cust.middle_name
        cust.last_name.strip!  if cust.last_name
        cust.email.strip!  if cust.email
        cust.zip.strip!  if cust.zip
        cust.city.strip!  if cust.city
        cust.street_addr1.strip!  if cust.street_addr1
        cust.street_addr2.strip!  if cust.street_addr2
        cust.home_phone.strip!  if cust.home_phone
        cust.work_phone.strip!  if cust.work_phone
        cust.mobile_phone.strip!  if cust.mobile_phone
        cust.other_phone.strip!  if cust.other_phone
        cust.spouse_name.strip!  if cust.spouse_name
        cust.referredBy_other_text.strip!  if cust.referredBy_other_text
        cust.ssn.strip!  if cust.ssn
        cust.driver_lic_num.strip!  if cust.driver_lic_num

        if cust.city.nil? or cust.city == ''
            ok = false
            addSessionError('City is required field.')
        end
        if cust.state_id.nil?
            ok = false
            addSessionError('You must select a state.')
        end
        if cust.first_name.nil? or cust.first_name == ''
            ok = false
            addSessionError('First name is required field.')
        end
        if cust.last_name.nil? or cust.last_name == ''
            ok = false
            addSessionError('Last name is required field.')
        end
        if cust.signup_store_id.nil?
            ok = false
            addSessionError('You must select a signup store.')
        end
        if cust.driver_lic_state_id.nil?
            ok = false
            addSessionError("You must select a driver's license state.")
        end
        if cust.email and cust.email != ''
            unless emailValid?(cust.email)
                ok = false
                addSessionError("Invalid email address.")
            end
        end
        if cust.home_phone and cust.home_phone != ''
            unless phoneValid?(cust.home_phone)
                ok = false
                addSessionError("Invalid home phone.")
            end
        end
        if cust.work_phone and cust.work_phone != ''
            unless phoneValid?(cust.work_phone)
                ok = false
                addSessionError("Invalid work phone.")
            end
        end
        if cust.mobile_phone and cust.mobile_phone != ''
            unless phoneValid?(cust.mobile_phone)
                ok = false
                addSessionError("Invalid mobile phone.")
            end
        end
        if cust.other_phone and cust.other_phone != ''
            unless phoneValid?(cust.other_phone)
                ok = false
                addSessionError("Invalid other phone.")
            end
        end
        return ok
    end
    
    
    def unzeroCid(cust)
        if cust.cid.nil? or cust.cid == '' or cust.cid == '0'
            cust.cid = cust.id
            cust.save
        end
    end


    # POST /customers
    # POST /customers.json
    def create
        @customer = Customer.new(params[:customer])
        ok = validateCustomer?(@customer)
        if formHasGf?
            okUrl = '/top/gf'
            errAction = 'gfnew'
            @isGroundFloor = true
            @colorZone = 'GF'
        else
            okUrl = customers_url
            errAction = 'new'
        end

        respond_to do |format|
            if ok and @customer.save
                unzeroCid(@customer)
                format.html { redirect_to okUrl,
                              notice: 'Customer was successfully created.' }
                format.json { render json: @customer, status: :created,
                                     location: @customer }
            else
                prepFormVariables(@customer)
                format.html { render action: errAction }
                format.json { render json: @customer.errors,
                                     status: :unprocessable_entity }
            end
        end
    end

    # PUT /customers/1
    # PUT /customers/1.json
    def update
        @customer = Customer.find(params[:id])

        respond_to do |format|
            @customer.assign_attributes(params[:customer])
            parok = validateCustomer?(@customer)
            if formHasGf?
                okUrl = '/top/gf'
                errAction = 'gfedit'
                @isGroundFloor = true
                @colorZone = 'GF'
            else
                okUrl = customers_url
                errAction = 'edit'
            end
            saveok = false
            if parok
                saveok = @customer.save
            end
            if parok and saveok
                unzeroCid(@customer)
                format.html { redirect_to okUrl,
                              notice: 'Customer was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@customer)
                format.html { render action: errAction }
                format.json { render json: @customer.errors,
                                     status: :unprocessable_entity }
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
