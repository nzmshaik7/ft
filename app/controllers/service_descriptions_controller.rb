class ServiceDescriptionsController < ApplicationController

    before_filter :database_area

    def prepFormVariables
        @serviceCategories = ServiceCategory.all
        @serviceCategoryCollect = @serviceCategories.collect { |p|
            [ p.name, p.id ] 
        }
    end

    # GET /service_descriptions
    # GET /service_descriptions.json
    def index
        @service_descriptions = ServiceDescription.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_descriptions }
        end
    end

    # GET /service_descriptions/1
    # GET /service_descriptions/1.json
    def show
        @service_description = ServiceDescription.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_description }
        end
    end

    # GET /service_descriptions/new
    # GET /service_descriptions/new.json
    def new
        @service_description = ServiceDescription.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_description }
        end
    end

    # GET /service_descriptions/1/edit
    def edit
        @service_description = ServiceDescription.find(params[:id])
        prepFormVariables
    end

    # POST /service_descriptions
    # POST /service_descriptions.json
    def create
        @service_description = ServiceDescription.new(params[:service_description])

        respond_to do |format|
            if @service_description.save
                format.html { redirect_to service_descriptions_url,
                              notice: 'ServiceDescription was successfully created.' }
                format.json { render json: @service_description, status: :created, location: @service_description }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @service_description.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_descriptions/1
    # PUT /service_descriptions/1.json
    def update
        @service_description = ServiceDescription.find(params[:id])

        respond_to do |format|
            if @service_description.update_attributes(params[:service_description])
                format.html { redirect_to service_descriptions_url,
                              notice: 'ServiceDescription was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @service_description.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_descriptions/1
    # DELETE /service_descriptions/1.json
    def destroy
        @service_description = ServiceDescription.find(params[:id])
        @service_description.destroy

        respond_to do |format|
            format.html { redirect_to service_descriptions_url }
            format.json { head :no_content }
        end
    end
end
