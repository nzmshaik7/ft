class UsedPartsController < ApplicationController

    before_action :database_area, :except => [:gfnew, :gfindex, :gfedit, 
                                              :gfnewplus, :update, :create,  ]
    before_action :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, 
                                              :gfnewplus, :update, :create,  ]
    include ApplicationHelper

   

    def prepFormVariables
	@stores = Store.all
	@storeCollect = @stores.collect { |p|
		[ p.name, p.id ]
	}

	@vehicles = Vehicle.all
	@vehicleCollect = @vehicles.collect { |p|
		[ p.vin, p.id ]
	}
	
	@part_manufacturers = PartManufacturer.all
        @part_manufacturerCollect = @part_manufacturers.collect { |p|
            [ p.name, p.id ]
        }

	@part_names = PartName.all
        @part_nameCollect = @part_names.collect { |p|
            [ p.name, p.id ]
        }

	
    end


    # GET /used_parts
    # GET /used_parts.json
    def index
        #@parts = Part.find(:all, :order => 'part_number')
	@used_parts = UsedPart.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @used_parts }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /used_parts/1
    # GET /used_parts/1.json
    def show
        @used_part = UsedPart.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @used_part}
        end
    end


    # GET /used_parts/new
    # GET /used_parts/new.json
    def new
        @used_part = UsedPart.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @used_part}
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
        @used_part = UsedPart.find(params[:id])
        prepFormVariables
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validatePart?(part)
        ok = true

        if part.store_id.nil?
            ok = false
            addSessionError('You must select a Store.')
        end
	if part.vehicle_id.nil?
            ok = false
            addSessionError('You must select a Vehicle.')
        end
	
	if part.part_manufacturer_id.nil?
            ok = false
            addSessionError('You must select a Part Manufacturer')
        end

        if part.part_name_id.nil?
            ok = false
            addSessionError('You must select a (generic) Part Name')
        end
        
        if part.quantity.nil? or part.quantity == ''
            ok = false
            addSessionError('Quantity is required field.')
        end

        return ok
    end


    # POST /used_parts
    # POST /used_parts.json
    def create
        @used_part = UsedPart.new(params.require(:used_part).permit(:store_id, :vehicle_id, :part_manufacturer_id, :part_name_id, :quantity))
        #savok = saveNewManufNam(@used_part)
        ok = validatePart?(@used_part)
        okUrl, errAction = setSaveAction('new', used_parts_url)
        if params[:is_plus]
            errAction = 'gfnewplus'
        end

        respond_to do |format|
            #if savok and ok and @used_parts_cost.save
	    if ok and @used_part.save
                format.html { redirect_to okUrl,
                              notice: 'Used parts info is successfully created.' }
                format.json { render json: @used_part, status: :created,
                                     location: @used_part }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @used_part.errors,
                                     status: :unprocessable_entity }
            end
        end
    end

=begin
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
=end

    # PUT /@used_parts/1
    # PUT /@used_parts/1.json
    def update
        @used_part = UsedPart.find(params[:id])

        respond_to do |format|
            @used_part.assign_attributes(params.require(:used_part).permit(:store_id, :vehicle_id, :part_manufacturer_id, :part_name_id, :quantity))
            parok = validatePart?(@used_part)
            okUrl, errAction = setSaveAction('edit', used_part_url)
            saveok = false
            if parok
                saveok = @used_part.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                              notice: 'Used Part Cost was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @used_part.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /used_parts/1
    # DELETE /used_parts/1.json
    def destroy
        @used_part = UsedPart.find(params[:id])
        @used_part.destroy

        respond_to do |format|
            format.html { redirect_to used_parts_url }
            format.json { head :no_content }
        end
    end

end
