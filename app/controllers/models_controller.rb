class ModelsController < ApplicationController

    before_action :database_area, :except => [:gfnew, :gfindex, :gfedit,
                                              :update, :create, ]
    before_action :gf_area,       :only   => [:gfnew, :gfindex, :gfedit,
                                              :update, :create, ]
    include ApplicationHelper


    def prepFormVariables
        @makes = Make.all
        @makeCollect = @makes.collect { |p|
            [ p.name, p.id ] 
        }
    end
    
    


    # GET /models
    # GET /models.json
    def index
        @models = Model.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @models }
        end
    end


    def gfindex
        @isGroundFloor = true
        index
    end


    # GET /models/1
    # GET /models/1.json
    def show
        @model = Model.find(params[:id])
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @model }
        end
    end


    # GET /models/new
    # GET /models/new.json
    def new
        @model = Model.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @model }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /models/1/edit
    def edit
        @model = Model.find(params[:id])
        prepFormVariables
    end


    def gfedit
        @isGroundFloor = true
        edit
    end


    def validateModel?(modl, isNew)
        ok = true

        if modl.make_id.nil?
            ok = false
            addSessionError('You must select a Make.')
        end

        modl.name.strip!  if modl.name
        if modl.name.nil? or modl.name == ''
            ok = false
            addSessionError('Model name is required field.')
        else
            if isNew
                conflict = Model.where("name like ?", modl.name)
                for c in conflict
                    if c.make_id == modl.make_id
                        ok = false
                        addSessionError('That Model is already in the ' +
                                        'system.')
                        break
                    end
                end
            end
        end

        if modl.first_year_made
            if modl.first_year_made < 1900 or modl.first_year_made > 2200
                ok = false
                addSessionError('Invalid first year made, 4 digits please.')
            end
        end
        if modl.last_year_made
            if modl.last_year_made < 1900 or modl.last_year_made > 2200
                ok = false
                addSessionError('Invalid last year made, 4 digits please.')
            end
        end
        return ok
    end


    # POST /models
    # POST /models.json
    def create
        @model = Model.new(params.require(:model).permit(:first_year_made, :last_year_made, :make_id, :name))
        ok = validateModel?(@model, true)
        okUrl, errAction = setSaveAction('new', models_url)

        respond_to do |format|
            if ok and @model.save
                format.html { redirect_to okUrl,
                              notice: 'Model was successfully created.' }
                format.json { render json: @model, status: :created,
                                     location: @model }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @model.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # PUT /models/1
    # PUT /models/1.json
    def update
        @model = Model.find(params[:id])

        respond_to do |format|
            @model.assign_attributes(params.require(:model).permit(:first_year_made, :last_year_made, :make_id, :name))
            parok = validateModel?(@model, false)
            okUrl, errAction = setSaveAction('edit', models_url)
            saveok = false
            if parok
                saveok = @model.save
            end
            if parok and saveok
                format.html { redirect_to okUrl,
                              notice: 'Model was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: errAction }
                format.json { render json: @model.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /models/1
    # DELETE /models/1.json
    def destroy
        @model = Model.find(params[:id])
        @model.destroy

        respond_to do |format|
            format.html { redirect_to models_url }
            format.json { head :no_content }
        end
    end
end
