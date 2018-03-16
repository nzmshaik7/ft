class InventoriesController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @stores = Store.all
        @storeCollect = @stores.collect { |p|
            [ p.number + '/' + p.name, p.id ] 
        }
        @parts = Part.all
        @partCollect = @parts.collect { |p|
            [ p.name.name + '/' + p.part_number, p.id ] 
        }
    end

    # GET /inventories
    # GET /inventories.json
    def index
        @inventories = Inventory.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @inventories }
        end
    end

    # GET /inventories/1
    # GET /inventories/1.json
    def show
        @inventory = Inventory.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @inventory }
        end
    end

    # GET /inventories/new
    # GET /inventories/new.json
    def new
        @inventory = Inventory.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @inventory }
        end
    end

    # GET /inventories/1/edit
    def edit
        @inventory = Inventory.find(params[:id])
        prepFormVariables
    end

    # POST /inventories
    # POST /inventories.json
    def create
        @inventory = Inventory.new(params.require(:inventory).permit(:count, :part_id, :store_id)
)

        respond_to do |format|
            if @inventory.save
                format.html { redirect_to inventories_url,
                              notice: 'Inventory was successfully created.' }
                format.json { render json: @inventory, status: :created, location: @inventory }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @inventory.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /inventories/1
    # PUT /inventories/1.json
    def update
        @inventory = Inventory.find(params[:id])

        respond_to do |format|
            if @inventory.update_attributes(params.require(:inventory).permit(:count, :part_id, :store_id)
)
                format.html { redirect_to inventories_url,
                              notice: 'Inventory was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @inventory.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /inventories/1
    # DELETE /inventories/1.json
    def destroy
        @inventory = Inventory.find(params[:id])
        @inventory.destroy

        respond_to do |format|
            format.html { redirect_to inventories_url }
            format.json { head :no_content }
        end
    end
end
