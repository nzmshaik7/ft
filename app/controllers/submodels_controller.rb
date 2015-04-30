class SubmodelsController < ApplicationController

    before_filter :only_allow_admins

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

    # GET /submodels/1/edit
    def edit
        @submodel = Submodel.find(params[:id])
        prepFormVariables
    end

    # POST /submodels
    # POST /submodels.json
    def create
        @submodel = Submodel.new(params[:submodel])

        respond_to do |format|
            if @submodel.save
                format.html { redirect_to submodels_url,
                              notice: 'Submodel was successfully created.' }
                format.json { render json: @submodel, status: :created, location: @submodel }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @submodel.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /submodels/1
    # PUT /submodels/1.json
    def update
        @submodel = Submodel.find(params[:id])

        respond_to do |format|
            if @submodel.update_attributes(params[:submodel])
                format.html { redirect_to submodels_url,
                              notice: 'Submodel was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @submodel.errors, status: :unprocessable_entity }
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
