class ServicePartsController < ApplicationController

    before_filter :only_allow_admins

    def prepFormVariables
        @serviceLineItems = ServiceLineItem.all
        @serviceLineItemCollect = @serviceLineItems.collect { |p|
            [ p.id.to_s + ':' + p.descText, p.id ] 
        }
        @parts = Part.all
        @partCollect = @parts.collect { |p|
            [ p.id.to_s + ':' + p.part_name.name, p.id ] 
        }
    end

    # GET /service_parts
    # GET /service_parts.json
    def index
        @service_parts = ServicePart.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_parts }
        end
    end

    # GET /service_parts/1
    # GET /service_parts/1.json
    def show
        @service_part = ServicePart.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_part }
        end
    end

    # GET /service_parts/new
    # GET /service_parts/new.json
    def new
        @service_part = ServicePart.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_part }
        end
    end

    # GET /service_parts/1/edit
    def edit
        @service_part = ServicePart.find(params[:id])
        prepFormVariables
    end

    # POST /service_parts
    # POST /service_parts.json
    def create
        @service_part = ServicePart.new(params[:service_part])

        respond_to do |format|
            if @service_part.save
                format.html { redirect_to service_parts_url,
                              notice: 'ServicePart was successfully created.' }
                format.json { render json: @service_part, status: :created, location: @service_part }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @service_part.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_parts/1
    # PUT /service_parts/1.json
    def update
        @service_part = ServicePart.find(params[:id])

        respond_to do |format|
            if @service_part.update_attributes(params[:service_part])
                format.html { redirect_to service_parts_url,
                              notice: 'ServicePart was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @service_part.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_parts/1
    # DELETE /service_parts/1.json
    def destroy
        @service_part = ServicePart.find(params[:id])
        @service_part.destroy

        respond_to do |format|
            format.html { redirect_to service_parts_url }
            format.json { head :no_content }
        end
    end
end
