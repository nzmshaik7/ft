class PartNamesController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit,
                                              :update, :create, ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit,
                                              :update, :create, ]
    include ApplicationHelper


    # GET /part_names
    # GET /part_names.json
    def index
        @part_names = PartName.find(:all, :order => 'name')

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @part_names }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
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


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /part_names/1/edit
    def edit
        @part_name = PartName.find(params[:id])
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validatePartName?(partname)
        ok = true

        partname.name.strip!  if partname.name
        if partname.name.nil? or partname.name == ''
            ok = false
            addSessionError('Part Name is required field.')
        end

        return ok
    end


    # POST /part_names
    # POST /part_names.json
    def create
        @part_name = PartName.new(params[:part_name])
        ok = validatePartName?(@part_name)
        okUrl, errAction = setSaveAction('new', part_names_url)

        respond_to do |format|
            if ok and @part_name.save
                format.html { redirect_to okUrl,
                              notice: 'PartName was successfully created.' }
                format.json { render json: @part_name, status: :created,
                                     location: @part_name }
            else
                format.html { render action: errAction }
                format.json { render json: @part_name.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /part_names/1
    # PUT /part_names/1.json
    def update
        @part_name = PartName.find(params[:id])

        respond_to do |format|
            @part_name.assign_attributes(params[:part_name])
            parok = validatePartName?(@part_name)
            okUrl, errAction = setSaveAction('edit', part_names_url)
            saveok = false
            if parok
                saveok = @part_name.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                              notice: 'PartName was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: errAction }
                format.json { render json: @part_name.errors,
                                     status: :unprocessable_entity }
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
