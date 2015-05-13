class PaymentsController < ApplicationController

    before_filter :only_allow_admins

    include CustomersHelper

    def prepFormVariables(payment=nil)
        @customers = Customer.all
        @customerCollect = @customers.collect { |p|
            [ customerName2(p), p.id ] 
        }
        @invoices = Invoice.all
        @invoiceCollect = @invoices.collect { |p|
            [ p.invoice_number, p.id ] 
        }
        @contracts = Contract.all
        @contractCollect = @contracts.collect { |p|
            [ p.number, p.id ] 
        }
        @paymentMethods = PaymentMethod.all
        @paymentMethodCollect = @paymentMethods.collect { |p|
            [ customerName2(p.customer) + '/' + p.payment_type.name, p.id ] 
        }

        @selStatus = 0
        if payment
            if payment.status == Payment::STATUS_APPOVED or
               payment.status == Payment::STATUS_PENDING or
               payment.status == Payment::STATUS_DENIED 
                @selStatus = payment.status
            end
        end
        @statusOptions = [
            [ "Select",   0  ],
            [ "Approved",  Payment::STATUS_APPOVED ],
            [ "Denied",    Payment::STATUS_DENIED ],
            [ "Pending",   Payment::STATUS_PENDING ],
        ]
    end

    # GET /payments
    # GET /payments.json
    def index
        @payments = Payment.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @payments }
        end
    end

    # GET /payments/1
    # GET /payments/1.json
    def show
        @payment = Payment.find(params[:id])
        prepFormVariables(@payment)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @payment }
        end
    end

    # GET /payments/new
    # GET /payments/new.json
    def new
        @payment = Payment.new
        prepFormVariables(@payment)

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @payment }
        end
    end

    # GET /payments/1/edit
    def edit
        @payment = Payment.find(params[:id])
        prepFormVariables(@payment)
    end

    # POST /payments
    # POST /payments.json
    def create
        @payment = Payment.new(params[:payment])

        respond_to do |format|
            if @payment.save
                format.html { redirect_to payments_url,
                              notice: 'Payment was successfully created.' }
                format.json { render json: @payment, status: :created, location: @payment }
            else
                prepFormVariables(@payment)
                format.html { render action: "new" }
                format.json { render json: @payment.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /payments/1
    # PUT /payments/1.json
    def update
        @payment = Payment.find(params[:id])

        respond_to do |format|
            if @payment.update_attributes(params[:payment])
                format.html { redirect_to payments_url,
                              notice: 'Payment was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@payment)
                format.html { render action: "edit" }
                format.json { render json: @payment.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /payments/1
    # DELETE /payments/1.json
    def destroy
        @payment = Payment.find(params[:id])
        @payment.destroy

        respond_to do |format|
            format.html { redirect_to payments_url }
            format.json { head :no_content }
        end
    end
end