class LineItemPurposesController < ApplicationController

    before_filter :only_allow_admins

    # GET /line_item_purposes
    # GET /line_item_purposes.json
    def index
        @line_item_purposes = LineItemPurpose.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @line_item_purposes }
        end
    end

    # GET /line_item_purposes/1
    # GET /line_item_purposes/1.json
    def show
        @line_item_purpose = LineItemPurpose.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @line_item_purpose }
        end
    end

    # GET /line_item_purposes/new
    # GET /line_item_purposes/new.json
    def new
        @line_item_purpose = LineItemPurpose.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @line_item_purpose }
        end
    end

    # GET /line_item_purposes/1/edit
    def edit
        @line_item_purpose = LineItemPurpose.find(params[:id])
    end

    # POST /line_item_purposes
    # POST /line_item_purposes.json
    def create
        @line_item_purpose = LineItemPurpose.new(params[:line_item_purpose])

        respond_to do |format|
            if @line_item_purpose.save
                format.html { redirect_to line_item_purposes_url,
                              notice: 'LineItemPurpose was successfully created.' }
                format.json { render json: @line_item_purpose, status: :created, location: @line_item_purpose }
            else
                format.html { render action: "new" }
                format.json { render json: @line_item_purpose.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /line_item_purposes/1
    # PUT /line_item_purposes/1.json
    def update
        @line_item_purpose = LineItemPurpose.find(params[:id])

        respond_to do |format|
            if @line_item_purpose.update_attributes(params[:line_item_purpose])
                format.html { redirect_to line_item_purposes_url,
                              notice: 'LineItemPurpose was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @line_item_purpose.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /line_item_purposes/1
    # DELETE /line_item_purposes/1.json
    def destroy
        @line_item_purpose = LineItemPurpose.find(params[:id])
        @line_item_purpose.destroy

        respond_to do |format|
            format.html { redirect_to line_item_purposes_url }
            format.json { head :no_content }
        end
    end
end
