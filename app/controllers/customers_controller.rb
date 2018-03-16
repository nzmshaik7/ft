class CustomersController < ApplicationController

    before_action :database_area, :except => [:gfnew, :gfindex, :gfedit, 
                                              :gfsearch1, :gfmatch1, 
                                              :svsearch1,
                                              ]
    before_action :gf_area,       :only   => [:gfnew, :gfindex, :gfedit,
                                              :gfsearch1, :gfmatch1, 
                                              :svsearch1,
                                              ]
    include CustomersHelper
    include ApplicationHelper


    def prepFormVariables(customer=nil)
        @states = State.all
        @stateCollect = @states.collect { |p|
            [ p.name, p.id ] 
        }

        @users = User.all
        @userCollect = @users.collect { |p|
            [ p.first_name + ' ' + p.last_name, p.id ] unless p.first_name.nil?
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


    def gfindex
        @isGroundFloor = true
        index
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


    def gfedit
        @isGroundFloor = true
        edit
    end


    def gfsearch1
        prepFormVariables
        prepDateCollects
    end


    def svsearch1
        @isSvSelect = true
        gfsearch1
    end


    # Get search criteria from form and find all matching customers.
    # View will render a list of hyperlinks that will point to the
    # given controller and method page for that customer.
    #
    def gfmatch1
        @target_cm = params[:target_cm]
        if @target_cm and @target_cm[0] == '/'  # Whack leading slash
            @target_cm = @target_cm[1..-1] 
        end

        whereHash = Hash.new
        whereClause = ''
        andop = ''
        cust = params[:customer]

        if cust[:first_name] and cust[:first_name].length > 0
            whereHash[:first_name] = "%#{ cust[:first_name] }%"
            whereClause += andop + " first_name like :first_name"
            andop = ' AND'
        end
        if cust[:last_name] and cust[:last_name].length > 0
            whereHash[:last_name] = "%#{ cust[:last_name] }%"
            whereClause += andop + " last_name like :last_name"
            andop = ' AND'
        end
        if cust[:zip] and cust[:zip].length > 0
            whereHash[:zip] = "%#{ cust[:zip] }%"
            whereClause += andop + " zip like :zip"
            andop = ' AND'
        end
        if cust[:zip] and cust[:zip].length > 0
            whereHash[:zip] = "%#{ cust[:zip] }%"
            whereClause += andop + " zip like :zip"
            andop = ' AND'
        end
        if cust[:state_id] and cust[:state_id].to_i > 0
            whereHash[:state_id] = cust[:state_id]
            whereClause += andop + " state_id = :state_id"
            andop = ' AND'
        end
        if cust[:signup_store_id] and cust[:signup_store_id].to_i > 0
            whereHash[:signup_store_id] = cust[:signup_store_id]
            whereClause += andop + " signup_store_id = :signup_store_id"
            andop = ' AND'
        end
        if cust[:phone] and cust[:phone].length > 0
            whereHash[:phone] = "%#{ cust[:phone] }%"
            whereClause += andop + " (home_phone like :phone or mobile_phone" +
                                   " like :phone or other_phone like :phone)"
            andop = ' AND'
        end

        logger.info("==== cust whereHash: #{whereHash.inspect}")
        logger.info("==== cust whereClause: #{whereClause}")

        if whereClause == ''
            @customers = Customer.all
        else
            @customers = Customer.where(whereClause, whereHash)
        end
        render :gfindex
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
        #cust.spouse_name.strip!  if cust.spouse_name
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
        @customer = Customer.new(params.require(:customer).permit(:can_text_home_phone, :can_text_mobile_phone, 
                    :can_text_other_phone, :can_text_work_phone, :cid, 
                    :city, :date_of_birth, :driver_lic_image_id, 
                    :driver_lic_num, :driver_lic_state_id, :gender, 
                    :home_phone, :is_aaa_member, :is_web_registered, 
                    :joined_date, :mobile_phone, :other_phone,
                    :referral_credits_earned, :referral_credits_used,
                    :referredBy_customer_id, :referredBy_id,
                    :referredBy_other_text, :signup_store_id,
                    #:spouse_id, :spouse_name,
		    :ssn, :state_id,
                    :street_addr1, :street_addr2, :user_id,
                    :video_testimony_url, :work_phone,
                    :written_testimony_id, :zip,
                    :first_name, :middle_name, :last_name, :email, 
                    :contact_method))
        ok = validateCustomer?(@customer)
        okUrl, errAction = setSaveAction('new', customers_url)

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
            @customer.assign_attributes(params.require(:customer).permit(:can_text_home_phone, :can_text_mobile_phone, 
                    :can_text_other_phone, :can_text_work_phone, :cid, 
                    :city, :date_of_birth, :driver_lic_image_id, 
                    :driver_lic_num, :driver_lic_state_id, :gender, 
                    :home_phone, :is_aaa_member, :is_web_registered, 
                    :joined_date, :mobile_phone, :other_phone,
                    :referral_credits_earned, :referral_credits_used,
                    :referredBy_customer_id, :referredBy_id,
                    :referredBy_other_text, :signup_store_id,
                    #:spouse_id, :spouse_name,
		    :ssn, :state_id,
                    :street_addr1, :street_addr2, :user_id,
                    :video_testimony_url, :work_phone,
                    :written_testimony_id, :zip,
                    :first_name, :middle_name, :last_name, :email, 
                    :contact_method))
            parok = validateCustomer?(@customer)
            okUrl, errAction = setSaveAction('edit', customers_url)
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
