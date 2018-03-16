class ServiceDescriptionsController < ApplicationController

    before_action :database_area, :except => [:gfnew, :gfindex, :gfedit,
                                              :update, :create, ]
    before_action :gf_area,       :only   => [:gfnew, :gfindex, :gfedit,
                                              :update, :create, ]
    include ApplicationHelper

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


    def gfindex
        @isGroundFloor = true
        index
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


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /service_descriptions/1/edit
    def edit
        @service_description = ServiceDescription.find(params[:id])
        prepFormVariables
    end


    def validateServiceDescription?(sd)
        ok = true

        sd.name.strip!  if sd.name
        if sd.name.nil? or sd.name == ''
            ok = false
            addSessionError('Name is required field.')
        end
        if sd.service_category_id.nil?
            ok = false
            addSessionError('You must select a Service Category.')
        end

        return ok
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    # POST /service_descriptions
    # POST /service_descriptions.json
    def create
        @service_description = ServiceDescription.new(params.require(:service_description).permit(:labor_hours_retail, :labor_rate_retail, :name, :service_category_id))
        ok = validateServiceDescription?(@service_description)
        okUrl, errAction = setSaveAction('new', service_descriptions_url)

        respond_to do |format|
            if ok and @service_description.save
                format.html { redirect_to okUrl,
                      notice: 'ServiceDescription was successfully created.' }
                format.json { render json: @service_description,
                                     status: :created,
                                     location: @service_description }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @service_description.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /service_descriptions/1
    # PUT /service_descriptions/1.json
    def update
        @service_description = ServiceDescription.find(params[:id])

        respond_to do |format|
            @service_description.assign_attributes(params.require(:service_description).permit(:labor_hours_retail, :labor_rate_retail, :name, :service_category_id))
            parok = validateServiceDescription?(@service_description)
            okUrl, errAction = setSaveAction('edit', service_descriptions_url)
            saveok = false
            if parok
                saveok = @service_description.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                       notice: 'ServiceDescription was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @service_description.errors,
                                     status: :unprocessable_entity }
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
