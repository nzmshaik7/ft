class PurchaseOrdersController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @vendors = Vendor.all
        @vendorCollect = @vendors.collect { |p|
            [ p.name, p.id ] 
        }
    end


    # GET /purchase_orders
    # GET /purchase_orders.json
    def index
        @purchase_orders = PurchaseOrder.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @purchase_orders }
        end
    end


    # GET /purchase_orders/1
    # GET /purchase_orders/1.json
    def show
        @purchase_order = PurchaseOrder.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @purchase_order }
        end
    end


    # GET /purchase_orders/new
    # GET /purchase_orders/new.json
    def new
        @purchase_order = PurchaseOrder.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @purchase_order }
        end
    end


    # GET /purchase_orders/1/edit
    def edit
        @purchase_order = PurchaseOrder.find(params[:id])
        prepFormVariables
    end


    # POST /purchase_orders
    # POST /purchase_orders.json
    def create
        @purchase_order = PurchaseOrder.new(params.require(:purchase_order).permit(:date_time, :po_number, :vendor_id))

        respond_to do |format|
            if @purchase_order.save
                format.html { redirect_to purchase_orders_url,
                           notice: 'Purchase order was successfully created.' }
                format.json { render json: @purchase_order,
                              status: :created, location: @purchase_order }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @purchase_order.errors,
                              status: :unprocessable_entity }
            end
        end
    end


    # PUT /purchase_orders/1
    # PUT /purchase_orders/1.json
    def update
        @purchase_order = PurchaseOrder.find(params[:id])

        respond_to do |format|
            if @purchase_order.update_attributes(params.require(:purchase_order).permit(:date_time, :po_number, :vendor_id))
                format.html { redirect_to purchase_orders_url,
                          notice: 'Purchase order was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @purchase_order.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /purchase_orders/1
    # DELETE /purchase_orders/1.json
    def destroy
        @purchase_order = PurchaseOrder.find(params[:id])
        @purchase_order.destroy

        respond_to do |format|
            format.html { redirect_to purchase_orders_url }
            format.json { head :no_content }
        end
    end
end
