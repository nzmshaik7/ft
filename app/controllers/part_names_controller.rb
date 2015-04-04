class PartNamesController < ApplicationController
    # GET /part_names
    # GET /part_names.json
    def index
        @part_names = PartName.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @part_names }
        end
    end

    # GET /part_names/1
    # GET /part_names/1.json
    def show
        @part_name = PartName.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @part_name }
        end
    end

    # GET /part_names/new
    # GET /part_names/new.json
    def new
        @part_name = PartName.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @part_name }
        end
    end

    # GET /part_names/1/edit
    def edit
        @part_name = PartName.find(params[:id])
    end

    # POST /part_names
    # POST /part_names.json
    def create
        @part_name = PartName.new(params[:part_name])

        respond_to do |format|
            if @part_name.save
                format.html { redirect_to partnames_url,
                              notice: 'PartName was successfully created.' }
                format.json { render json: @part_name, status: :created, location: @part_name }
            else
                format.html { render action: "new" }
                format.json { render json: @part_name.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /part_names/1
    # PUT /part_names/1.json
    def update
        @part_name = PartName.find(params[:id])

        respond_to do |format|
            if @part_name.update_attributes(params[:part_name])
                format.html { redirect_to partnames_url,
                              notice: 'PartName was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @part_name.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /part_names/1
    # DELETE /part_names/1.json
    def destroy
        @part_name = PartName.find(params[:id])
        @part_name.destroy

        respond_to do |format|
            format.html { redirect_to part_names_url }
            format.json { head :no_content }
        end
    end
end
