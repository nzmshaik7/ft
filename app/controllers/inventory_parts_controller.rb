class InventoryPartsController < ApplicationController

    before_filter :database_area

    def prepFormVariables
        @purchaseOrders = PurchaseOrder.all
        @purchaseOrdersCollect = @purchaseOrders.collect { |p|
            [ p.po_number, p.id ] 
        }
        @parts = Part.all
        @partCollect = @parts.collect { |p|
            [ p.id.to_s + ':' + p.part_name.name, p.id ] 
        }
    end


    # GET /inventory_parts
    # GET /inventory_parts.json
    def index
        @inventory_parts = InventoryPart.all
        prepFormVariables

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @inventory_parts }
        end
    end


    # GET /inventory_parts/1
    # GET /inventory_parts/1.json
    def show
        @inventory_part = InventoryPart.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @inventory_part }
        end
    end


    # GET /inventory_parts/new
    # GET /inventory_parts/new.json
    def new
        @inventory_part = InventoryPart.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @inventory_part }
        end
    end


    # GET /inventory_parts/1/edit
    def edit
        @inventory_part = InventoryPart.find(params[:id])
        prepFormVariables
    end


    # POST /inventory_parts
    # POST /inventory_parts.json
    def create
        @inventory_part = InventoryPart.new(params[:inventory_part])

        respond_to do |format|
            if @inventory_part.save
                format.html { redirect_to inventory_parts_url,
                           notice: 'Inventory part was successfully created.' }
                format.json { render json: @inventory_part,
                                     status: :created,
                                     location: @inventory_part }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @inventory_part.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /inventory_parts/1
    # PUT /inventory_parts/1.json
    def update
        @inventory_part = InventoryPart.find(params[:id])

        respond_to do |format|
            if @inventory_part.update_attributes(params[:inventory_part])
                format.html { redirect_to inventory_parts_url,
                            notice: 'Inventory part was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @inventory_part.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /inventory_parts/1
    # DELETE /inventory_parts/1.json
    def destroy
        @inventory_part = InventoryPart.find(params[:id])
        @inventory_part.destroy

        respond_to do |format|
            format.html { redirect_to inventory_parts_url }
            format.json { head :no_content }
        end
    end
end
