class UpgradesController < ApplicationController
    # GET /upgrades
    # GET /upgrades.json
    def index
        @upgrades = Upgrade.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @upgrades }
        end
    end

    # GET /upgrades/1
    # GET /upgrades/1.json
    def show
        @upgrade = Upgrade.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @upgrade }
        end
    end

    # GET /upgrades/new
    # GET /upgrades/new.json
    def new
        @upgrade = Upgrade.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @upgrade }
        end
    end

    # GET /upgrades/1/edit
    def edit
        @upgrade = Upgrade.find(params[:id])
    end

    # POST /upgrades
    # POST /upgrades.json
    def create
        @upgrade = Upgrade.new(params[:upgrade])

        respond_to do |format|
            if @upgrade.save
                format.html { redirect_to @upgrade, notice: 'Upgrade was successfully created.' }
                format.json { render json: @upgrade, status: :created, location: @upgrade }
            else
                format.html { render action: "new" }
                format.json { render json: @upgrade.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /upgrades/1
    # PUT /upgrades/1.json
    def update
        @upgrade = Upgrade.find(params[:id])

        respond_to do |format|
            if @upgrade.update_attributes(params[:upgrade])
                format.html { redirect_to @upgrade, notice: 'Upgrade was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @upgrade.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /upgrades/1
    # DELETE /upgrades/1.json
    def destroy
        @upgrade = Upgrade.find(params[:id])
        @upgrade.destroy

        respond_to do |format|
            format.html { redirect_to upgrades_url }
            format.json { head :no_content }
        end
    end
end
