class BgSystemsController < ApplicationController

    before_filter :database_area

    # GET /bg_systems
    # GET /bg_systems.json
    def index
        @bg_systems = BgSystem.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @bg_systems }
        end
    end

    # GET /bg_systems/1
    # GET /bg_systems/1.json
    def show
        @bg_system = BgSystem.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @bg_system }
        end
    end

    # GET /bg_systems/new
    # GET /bg_systems/new.json
    def new
        @bg_system = BgSystem.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @bg_system }
        end
    end

    # GET /bg_systems/1/edit
    def edit
        @bg_system = BgSystem.find(params[:id])
    end

    # POST /bg_systems
    # POST /bg_systems.json
    def create
        @bg_system = BgSystem.new(params[:bg_system])

        respond_to do |format|
            if @bg_system.save
                format.html { redirect_to bg_systems_url,
                              notice: 'BgSystem was successfully created.' }
                format.json { render json: @bg_system, status: :created, location: @bg_system }
            else
                format.html { render action: "new" }
                format.json { render json: @bg_system.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /bg_systems/1
    # PUT /bg_systems/1.json
    def update
        @bg_system = BgSystem.find(params[:id])

        respond_to do |format|
            if @bg_system.update_attributes(params[:bg_system])
                format.html { redirect_to bg_systems_url,
                              notice: 'BgSystem was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @bg_system.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /bg_systems/1
    # DELETE /bg_systems/1.json
    def destroy
        @bg_system = BgSystem.find(params[:id])
        @bg_system.destroy

        respond_to do |format|
            format.html { redirect_to bg_systems_url }
            format.json { head :no_content }
        end
    end
end
