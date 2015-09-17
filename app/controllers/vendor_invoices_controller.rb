class VendorInvoicesController < ApplicationController

    before_filter :database_area


    def prepFormVariables(vi=nil)
        @vendors = Vendor.all
        @vendorCollect = @vendors.collect { |p|
            [ p.name, p.id ] 
        }
        @purchaseOrders = PurchaseOrder.all
        @purchaseOrdersCollect = @purchaseOrders.collect { |p|
            [ p.po_number, p.id ] 
        }

        @selStatus = 0
        if vi
            if vi.status == VendorInvoice::STATUS_PAID or
               vi.status == VendorInvoice::STATUS_UNPAID 
                @selStatus = vi.status
            end
        end
        @statusOptions = [
            [ "Select",   0  ],
            [ "Paid",     VendorInvoice::STATUS_PAID ],
            [ "Unpaid",   VendorInvoice::STATUS_UNPAID ],
        ]
    end


    # GET /vendor_invoices
    # GET /vendor_invoices.json
    def index
        @vendor_invoices = VendorInvoice.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @vendor_invoices }
        end
    end


    # GET /vendor_invoices/1
    # GET /vendor_invoices/1.json
    def show
        @vendor_invoice = VendorInvoice.find(params[:id])
        prepFormVariables(@vendor_invoice)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @vendor_invoice }
        end
    end


    # GET /vendor_invoices/new
    # GET /vendor_invoices/new.json
    def new
        @vendor_invoice = VendorInvoice.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @vendor_invoice }
        end
    end


    # GET /vendor_invoices/1/edit
    def edit
        @vendor_invoice = VendorInvoice.find(params[:id])
        prepFormVariables(@vendor_invoice)
    end


    # POST /vendor_invoices
    # POST /vendor_invoices.json
    def create
        @vendor_invoice = VendorInvoice.new(params[:vendor_invoice])

        respond_to do |format|
            if @vendor_invoice.save
                format.html { redirect_to vendor_invoices_url,
                           notice: 'Vendor invoice was successfully created.' }
                format.json { render json: @vendor_invoice,
                                  status: :created, location: @vendor_invoice }
            else
                prepFormVariables(@vendor_invoice)
                format.html { render action: "new" }
                format.json { render json: @vendor_invoice.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /vendor_invoices/1
    # PUT /vendor_invoices/1.json
    def update
        @vendor_invoice = VendorInvoice.find(params[:id])

        respond_to do |format|
            if @vendor_invoice.update_attributes(params[:vendor_invoice])
                format.html { redirect_to vendor_invoices_url,
                           notice: 'Vendor invoice was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@vendor_invoice)
                format.html { render action: "edit" }
                format.json { render json: @vendor_invoice.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /vendor_invoices/1
    # DELETE /vendor_invoices/1.json
    def destroy
        @vendor_invoice = VendorInvoice.find(params[:id])
        @vendor_invoice.destroy

        respond_to do |format|
            format.html { redirect_to vendor_invoices_url }
            format.json { head :no_content }
        end
    end
end
