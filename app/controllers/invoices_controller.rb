class InvoicesController < ApplicationController

    before_action :database_area

    include CustomersHelper

    def prepFormVariables(invoice=nil)
        @customers = Customer.all
        @customerCollect = @customers.collect { |p|
            [ customerName2(p), p.id ] 
        }

        @selStatus = 0
        if invoice
            if invoice.status == Invoice::STATUS_PAID or
               invoice.status == Invoice::STATUS_UNPAID 
                @selStatus = invoice.status
            end
        end
        # logger.info("=== status is #{@selStatus}")
        @statusOptions = [
            [ "Select",   0  ],
            [ "Paid",     Invoice::STATUS_PAID ],
            [ "Unpaid",   Invoice::STATUS_UNPAID ],
        ]
    end

    # GET /invoices
    # GET /invoices.json
    def index
        @invoices = Invoice.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @invoices }
        end
    end

    # GET /invoices/1
    # GET /invoices/1.json
    def show
        @invoice = Invoice.find(params[:id])
        prepFormVariables(@invoice)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @invoice }
        end
    end

    # GET /invoices/new
    # GET /invoices/new.json
    def new
        @invoice = Invoice.new
        prepFormVariables(@invoice)

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @invoice }
        end
    end

    # GET /invoices/1/edit
    def edit
        @invoice = Invoice.find(params[:id])
        prepFormVariables(@invoice)
    end

    # POST /invoices
    # POST /invoices.json
    def create
        @invoice = Invoice.new(params.require(:invoice).permit(:customer_id, :date_time, :invoice_number, :status))

        respond_to do |format|
            if @invoice.save
                format.html { redirect_to invoices_url,
                              notice: 'Invoice was successfully created.' }
                format.json { render json: @invoice, status: :created, location: @invoice }
            else
                prepFormVariables(@invoice)
                format.html { render action: "new" }
                format.json { render json: @invoice.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /invoices/1
    # PUT /invoices/1.json
    def update
        @invoice = Invoice.find(params[:id])

        respond_to do |format|
            if @invoice.update_attributes(params.require(:invoice).permit(:customer_id, :date_time, :invoice_number, :status))
                format.html { redirect_to invoices_url,
                              notice: 'Invoice was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@invoice)
                format.html { render action: "edit" }
                format.json { render json: @invoice.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /invoices/1
    # DELETE /invoices/1.json
    def destroy
        @invoice = Invoice.find(params[:id])
        @invoice.destroy

        respond_to do |format|
            format.html { redirect_to invoices_url }
            format.json { head :no_content }
        end
    end
end
