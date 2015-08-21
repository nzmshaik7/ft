class SubmodelsController < ApplicationController

    before_filter :database_area, :except => [:gfnew, :gfindex, :gfedit, ]
    before_filter :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, ]
    include ApplicationHelper


    def prepFormVariables
        @makes = Make.all
        @makeCollect = @makes.collect { |p|
            [ p.name, p.id ] 
        }
    end


    # GET /submodels
    # GET /submodels.json
    def index
        @submodels = Submodel.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @submodels }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /submodels/1
    # GET /submodels/1.json
    def show
        @submodel = Submodel.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @submodel }
        end
    end


    # GET /submodels/new
    # GET /submodels/new.json
    def new
        @submodel = Submodel.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @submodel }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    def validateSubmodel?(submodl, isNew)
        ok = true

        if submodl.make_id.nil?
            ok = false
            addSessionError('You must select a Make.')
        end

        submodl.name.strip!  if submodl.name
        if submodl.name.nil? or submodl.name == ''
            ok = false
            addSessionError('Submodel name is required field.')
        else
            if isNew
                conflict = Submodel.where("name like ?", submodl.name)
                for c in conflict
                    if c.make_id == submodl.make_id
                        ok = false
                        addSessionError('That Submodel is already in the ' +
                                        'system.')
                        break
                    end
                end
            end
        end

        return ok
    end


    # GET /submodels/1/edit
    def edit
        @submodel = Submodel.find(params[:id])
        prepFormVariables
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    # POST /submodels
    # POST /submodels.json
    def create
        @submodel = Submodel.new(params[:submodel])
        ok = validateSubmodel?(@submodel, true)
        okUrl, errAction = setSaveAction('new', submodels_url)

        respond_to do |format|
            if ok and @submodel.save
                format.html { redirect_to okUrl,
                              notice: 'Submodel was successfully created.' }
                format.json { render json: @submodel, status: :created,
                                                      location: @submodel }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @submodel.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /submodels/1
    # PUT /submodels/1.json
    def update
        @submodel = Submodel.find(params[:id])

        respond_to do |format|
            @submodel.assign_attributes(params[:submodel])
            parok = validateSubmodel?(@submodel, false)
            okUrl, errAction = setSaveAction('edit', submodels_url)
            saveok = false
            if parok
                saveok = @submodel.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                              notice: 'Submodel was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @submodel.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /submodels/1
    # DELETE /submodels/1.json
    def destroy
        @submodel = Submodel.find(params[:id])
        @submodel.destroy

        respond_to do |format|
            format.html { redirect_to submodels_url }
            format.json { head :no_content }
        end
    end
end
