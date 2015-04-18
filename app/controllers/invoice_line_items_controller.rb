class InvoiceLineItemsController < ApplicationController

    before_filter :only_allow_admins

    def prepFormVariables
        @invoices = Invoice.all
        @invoiceCollect = @invoices.collect { |p|
            [ p.invoice_number, p.id ] 
        }

        @purposes = LineItemPurpose.all
        @purposeCollect = @purposes.collect { |p|
            [ p.name, p.id ] 
        }

        @serviceVisits = ServiceVisit.all
        @serviceVisitCollect = @serviceVisits.collect { |p|
            [ p.id.to_s + ': ' + p.sdate.strftime("%b %d, %Y") + ' (' + 
              p.mileage + ' miles)', p.id ]
        }

        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmText + ' ' + p.license_plate, p.id ]
        }
    end

    # GET /invoice_line_items
    # GET /invoice_line_items.json
    def index
        @invoice_line_items = InvoiceLineItem.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @invoice_line_items }
        end
    end

    # GET /invoice_line_items/1
    # GET /invoice_line_items/1.json
    def show
        @invoice_line_item = InvoiceLineItem.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @invoice_line_item }
        end
    end

    # GET /invoice_line_items/new
    # GET /invoice_line_items/new.json
    def new
        @invoice_line_item = InvoiceLineItem.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @invoice_line_item }
        end
    end

    # GET /invoice_line_items/1/edit
    def edit
        @invoice_line_item = InvoiceLineItem.find(params[:id])
        prepFormVariables
    end

    # POST /invoice_line_items
    # POST /invoice_line_items.json
    def create
        @invoice_line_item = InvoiceLineItem.new(params[:invoice_line_item])

        respond_to do |format|
            if @invoice_line_item.save
                format.html { redirect_to invoice_line_items_url,
                              notice: 'InvoiceLineItem was successfully created.' }
                format.json { render json: @invoice_line_item, status: :created, location: @invoice_line_item }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @invoice_line_item.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /invoice_line_items/1
    # PUT /invoice_line_items/1.json
    def update
        @invoice_line_item = InvoiceLineItem.find(params[:id])

        respond_to do |format|
            if @invoice_line_item.update_attributes(params[:invoice_line_item])
                format.html { redirect_to invoice_line_items_url,
                              notice: 'InvoiceLineItem was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @invoice_line_item.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /invoice_line_items/1
    # DELETE /invoice_line_items/1.json
    def destroy
        @invoice_line_item = InvoiceLineItem.find(params[:id])
        @invoice_line_item.destroy

        respond_to do |format|
            format.html { redirect_to invoice_line_items_url }
            format.json { head :no_content }
        end
    end
end
