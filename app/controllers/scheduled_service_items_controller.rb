class ScheduledServiceItemsController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @scheduledServices = ScheduledService.all
        @scheduledServiceCollect = @scheduledServices.collect { |p|
            [ p.id.to_s + ': ' + p.serviceText, p.id ] 
        }
        @serviceDescriptions = ServiceDescription.all
        @serviceDescriptionCollect = @serviceDescriptions.collect { |p|
            [ p.name, p.id ] 
        }
    end

    # GET /scheduled_service_items
    # GET /scheduled_service_items.json
    def index
        @scheduled_service_items = ScheduledServiceItem.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @scheduled_service_items }
        end
    end

    # GET /scheduled_service_items/1
    # GET /scheduled_service_items/1.json
    def show
        @scheduled_service_item = ScheduledServiceItem.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @scheduled_service_item }
        end
    end

    # GET /scheduled_service_items/new
    # GET /scheduled_service_items/new.json
    def new
        @scheduled_service_item = ScheduledServiceItem.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @scheduled_service_item }
        end
    end

    # GET /scheduled_service_items/1/edit
    def edit
        @scheduled_service_item = ScheduledServiceItem.find(params[:id])
        prepFormVariables
    end

    # POST /scheduled_service_items
    # POST /scheduled_service_items.json
    def create
        @scheduled_service_item = ScheduledServiceItem.new(params.require(:scheduled_service_item).permit(:other, :scheduled_service_id, :service_description_id))

        respond_to do |format|
            if @scheduled_service_item.save
                format.html { redirect_to scheduled_service_items_url,
                              notice: 'ScheduledServiceItem was successfully created.' }
                format.json { render json: @scheduled_service_item, status: :created, location: @scheduled_service_item }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @scheduled_service_item.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /scheduled_service_items/1
    # PUT /scheduled_service_items/1.json
    def update
        @scheduled_service_item = ScheduledServiceItem.find(params[:id])

        respond_to do |format|
            if @scheduled_service_item.update_attributes(params.require(:scheduled_service_item).permit(:other, :scheduled_service_id, :service_description_id))
                format.html { redirect_to scheduled_service_items_url,
                              notice: 'ScheduledServiceItem was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @scheduled_service_item.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /scheduled_service_items/1
    # DELETE /scheduled_service_items/1.json
    def destroy
        @scheduled_service_item = ScheduledServiceItem.find(params[:id])
        @scheduled_service_item.destroy

        respond_to do |format|
            format.html { redirect_to scheduled_service_items_url }
            format.json { head :no_content }
        end
    end
end
