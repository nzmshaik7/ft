class ServiceLineItemsController < ApplicationController
    # GET /service_line_items
    # GET /service_line_items.json
    def index
        @service_line_items = ServiceLineItem.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_line_items }
        end
    end

    # GET /service_line_items/1
    # GET /service_line_items/1.json
    def show
        @service_line_item = ServiceLineItem.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_line_item }
        end
    end

    # GET /service_line_items/new
    # GET /service_line_items/new.json
    def new
        @service_line_item = ServiceLineItem.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_line_item }
        end
    end

    # GET /service_line_items/1/edit
    def edit
        @service_line_item = ServiceLineItem.find(params[:id])
    end

    # POST /service_line_items
    # POST /service_line_items.json
    def create
        @service_line_item = ServiceLineItem.new(params[:service_line_item])

        respond_to do |format|
            if @service_line_item.save
                format.html { redirect_to @service_line_item, notice: 'Service line item was successfully created.' }
                format.json { render json: @service_line_item, status: :created, location: @service_line_item }
            else
                format.html { render action: "new" }
                format.json { render json: @service_line_item.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_line_items/1
    # PUT /service_line_items/1.json
    def update
        @service_line_item = ServiceLineItem.find(params[:id])

        respond_to do |format|
            if @service_line_item.update_attributes(params[:service_line_item])
                format.html { redirect_to @service_line_item, notice: 'Service line item was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @service_line_item.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_line_items/1
    # DELETE /service_line_items/1.json
    def destroy
        @service_line_item = ServiceLineItem.find(params[:id])
        @service_line_item.destroy

        respond_to do |format|
            format.html { redirect_to service_line_items_url }
            format.json { head :no_content }
        end
    end
end
