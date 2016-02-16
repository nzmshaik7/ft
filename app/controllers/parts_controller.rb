class PartsController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit, 
                                              :gfnewplus, :update, :create,  ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, 
                                              :gfnewplus, :update, :create,  ]
    include ApplicationHelper

    def prepFormVariables
        @part_manufacturers = PartManufacturer.find(:all, :order => 'name')
        @part_manufacturerCollect = @part_manufacturers.collect { |p|
            [ p.name, p.id ]
        }
        @part_names = PartName.find(:all, :order => 'name')
        @part_nameCollect = @part_names.collect { |p|
            [ p.name, p.id ]
        }
    end


    # GET /parts
    # GET /parts.json
    def index
        @parts = Part.find(:all, :order => 'part_number')

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @parts }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /parts/1
    # GET /parts/1.json
    def show
        @part = Part.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @part }
        end
    end


    # GET /parts/new
    # GET /parts/new.json
    def new
        @part = Part.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @part }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    def gfnewplus
        @isGroundFloor = true
        new
    end


    # GET /parts/1/edit
    def edit
        @part = Part.find(params[:id])
        prepFormVariables
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validatePart?(part)
        ok = true

        if part.part_manufacturer.nil?
            ok = false
            addSessionError('You must select a Part Manufacturer.')
        end
        if part.part_name.nil?
            ok = false
            addSessionError('You must select a (generic) Part Name.')
        end

        part.description.strip!  if part.description
        part.part_number.strip!  if part.part_number
        if part.part_number.nil? or part.part_number == ''
            ok = false
            addSessionError('Part number is required field.')
        end
        if part.retail_price.nil?
            ok = false
            addSessionError('Part retail price is required field.')
        end

        return ok
    end


    # POST /parts
    # POST /parts.json
    def create
        @part = Part.new(params[:part])
        savok = saveNewManufNam(@part)
        ok = validatePart?(@part)
        okUrl, errAction = setSaveAction('new', parts_url)
        if params[:is_plus]
            errAction = 'gfnewplus'
        end

        respond_to do |format|
            if savok and ok and @part.save
                format.html { redirect_to okUrl,
                              notice: 'Part was successfully created.' }
                format.json { render json: @part, status: :created,
                                     location: @part }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @part.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    def saveNewManufNam(part)
        if part.part_manufacturer.nil?
            if params[:part_new_manuf] and 
                                       params[:part_new_manuf].strip.length > 0
                new_manuf = params[:part_new_manuf].strip
                if new_manuf.length > 0
                    for p in PartManufacturer.find(:all) 
                        if p.name.downcase == new_manuf.downcase
                            addSessionError("Part Manufacturer #{new_manuf} " +
                                            "already exists.")
                            return false
                        end
                    end
                    pm = PartManufacturer.new
                    pm.name = new_manuf
                    pm.save
                    part.part_manufacturer_id = pm.id
                end
            end
        end
        if part.part_name.nil?
            if params[:part_new_name] and 
                                      params[:part_new_name].strip.length > 0
                new_pname = params[:part_new_name].strip
                if new_pname.length > 0
                    for p in PartName.find(:all) 
                        if p.name.downcase == new_pname.downcase
                            addSessionError("Part Name #{new_pname} " +
                                            "already exists.")
                            return false
                        end
                    end
                    pn = PartName.new
                    pn.name = new_pname
                    pn.save
                    part.part_name_id = pn.id
                end
            end
        end
        return true
    end


    # PUT /parts/1
    # PUT /parts/1.json
    def update
        @part = Part.find(params[:id])

        respond_to do |format|
            @part.assign_attributes(params[:part])
            parok = validatePart?(@part)
            okUrl, errAction = setSaveAction('edit', parts_url)
            saveok = false
            if parok
                saveok = @part.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                              notice: 'Part was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @part.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /parts/1
    # DELETE /parts/1.json
    def destroy
        @part = Part.find(params[:id])
        @part.destroy

        respond_to do |format|
            format.html { redirect_to parts_url }
            format.json { head :no_content }
        end
    end

end
