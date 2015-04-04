class ServiceCategoriesController < ApplicationController
    # GET /service_categories
    # GET /service_categories.json
    def index
        @service_categories = ServiceCategory.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @service_categories }
        end
    end

    # GET /service_categories/1
    # GET /service_categories/1.json
    def show
        @service_category = ServiceCategory.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @service_category }
        end
    end

    # GET /service_categories/new
    # GET /service_categories/new.json
    def new
        @service_category = ServiceCategory.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @service_category }
        end
    end

    # GET /service_categories/1/edit
    def edit
        @service_category = ServiceCategory.find(params[:id])
    end

    # POST /service_categories
    # POST /service_categories.json
    def create
        @service_category = ServiceCategory.new(params[:service_category])

        respond_to do |format|
            if @service_category.save
                format.html { redirect_to @service_category, notice: 'Service category was successfully created.' }
                format.json { render json: @service_category, status: :created, location: @service_category }
            else
                format.html { render action: "new" }
                format.json { render json: @service_category.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /service_categories/1
    # PUT /service_categories/1.json
    def update
        @service_category = ServiceCategory.find(params[:id])

        respond_to do |format|
            if @service_category.update_attributes(params[:service_category])
                format.html { redirect_to @service_category, notice: 'Service category was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @service_category.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /service_categories/1
    # DELETE /service_categories/1.json
    def destroy
        @service_category = ServiceCategory.find(params[:id])
        @service_category.destroy

        respond_to do |format|
            format.html { redirect_to service_categories_url }
            format.json { head :no_content }
        end
    end
end
