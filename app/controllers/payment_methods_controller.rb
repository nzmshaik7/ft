class PaymentMethodsController < ApplicationController

    before_filter :only_allow_admins

    include CustomersHelper

    def prepFormVariables
        @customers = Customer.all
        @customerCollect = @customers.collect { |p|
            [ customerName2(p), p.id ] 
        }
        @paymentTypes = PaymentType.all
        @paymentTypeCollect = @paymentTypes.collect { |p|
            [ p.name, p.id ] 
        }
    end

    # GET /payment_methods
    # GET /payment_methods.json
    def index
        @payment_methods = PaymentMethod.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @payment_methods }
        end
    end

    # GET /payment_methods/1
    # GET /payment_methods/1.json
    def show
        @payment_method = PaymentMethod.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @payment_method }
        end
    end

    # GET /payment_methods/new
    # GET /payment_methods/new.json
    def new
        @payment_method = PaymentMethod.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @payment_method }
        end
    end

    # GET /payment_methods/1/edit
    def edit
        @payment_method = PaymentMethod.find(params[:id])
        prepFormVariables
    end

    # POST /payment_methods
    # POST /payment_methods.json
    def create
        @payment_method = PaymentMethod.new(params[:payment_method])

        respond_to do |format|
            if @payment_method.save
                format.html { redirect_to payment_methods_url,
                              notice: 'PaymentMethod was successfully created.' }
                format.json { render json: @payment_method, status: :created, location: @payment_method }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @payment_method.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /payment_methods/1
    # PUT /payment_methods/1.json
    def update
        @payment_method = PaymentMethod.find(params[:id])

        respond_to do |format|
            if @payment_method.update_attributes(params[:payment_method])
                format.html { redirect_to payment_methods_url,
                              notice: 'PaymentMethod was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @payment_method.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /payment_methods/1
    # DELETE /payment_methods/1.json
    def destroy
        @payment_method = PaymentMethod.find(params[:id])
        @payment_method.destroy

        respond_to do |format|
            format.html { redirect_to payment_methods_url }
            format.json { head :no_content }
        end
    end
end
