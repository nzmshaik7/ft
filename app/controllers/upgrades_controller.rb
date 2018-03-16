class UpgradesController < ApplicationController

    before_action :database_area

    def prepFormVariables
        @upgradeTypes = UpgradeType.all
        @upgradeTypeCollect = @upgradeTypes.collect { |p|
            [ p.name, p.id ] 
        }
        @contracts = Contract.all
        @contractCollect = @contracts.collect { |p|
            [ p.number, p.id ] 
        }
    end

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
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @upgrade }
        end
    end

    # GET /upgrades/new
    # GET /upgrades/new.json
    def new
        @upgrade = Upgrade.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @upgrade }
        end
    end

    # GET /upgrades/1/edit
    def edit
        @upgrade = Upgrade.find(params[:id])
        prepFormVariables
    end

    # POST /upgrades
    # POST /upgrades.json
    def create
        @upgrade = Upgrade.new(params.require(:upgrade).permit(:contract_id, :cost, :upgrade_type_id))

        respond_to do |format|
            if @upgrade.save
                format.html { redirect_to upgrades_url,
                              notice: 'Upgrade was successfully created.' }
                format.json { render json: @upgrade, status: :created, location: @upgrade }
            else
                prepFormVariables
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
            if @upgrade.update_attributes(params.require(:upgrade).permit(:contract_id, :cost, :upgrade_type_id))
                format.html { redirect_to upgrades_url,
                              notice: 'Upgrade was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
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
