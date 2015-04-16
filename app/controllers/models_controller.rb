class ModelsController < ApplicationController

    before_filter :only_allow_admins

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

    # GET /models/1/edit
    def edit
        @model = Model.find(params[:id])
        prepFormVariables
    end

    # POST /models
    # POST /models.json
    def create
        @model = Model.new(params[:model])

        respond_to do |format|
            if @model.save
                format.html { redirect_to models_url,
                              notice: 'Model was successfully created.' }
                format.json { render json: @model, status: :created, location: @model }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @model.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /models/1
    # PUT /models/1.json
    def update
        @model = Model.find(params[:id])

        respond_to do |format|
            if @model.update_attributes(params[:model])
                format.html { redirect_to models_url,
                              notice: 'Model was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @model.errors, status: :unprocessable_entity }
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
