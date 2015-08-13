class AutomaticDataLinkInfosController < ApplicationController

    before_filter :database_area

    def prepFormVariables
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ] 
        }
    end

    # GET /automatic_data_link_infos
    # GET /automatic_data_link_infos.json
    def index
        prepFormVariables
        @automatic_data_link_infos = AutomaticDataLinkInfo.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @automatic_data_link_infos }
        end
    end

    # GET /automatic_data_link_infos/1
    # GET /automatic_data_link_infos/1.json
    def show
        prepFormVariables
        @automatic_data_link_info = AutomaticDataLinkInfo.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @automatic_data_link_info }
        end
    end

    # GET /automatic_data_link_infos/new
    # GET /automatic_data_link_infos/new.json
    def new
        prepFormVariables
        @automatic_data_link_info = AutomaticDataLinkInfo.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @automatic_data_link_info }
        end
    end

    # GET /automatic_data_link_infos/1/edit
    def edit
        prepFormVariables
        @automatic_data_link_info = AutomaticDataLinkInfo.find(params[:id])
    end

    # POST /automatic_data_link_infos
    # POST /automatic_data_link_infos.json
    def create
        @automatic_data_link_info = AutomaticDataLinkInfo.new(params[:automatic_data_link_info])

        respond_to do |format|
            if @automatic_data_link_info.save
                format.html { redirect_to automatic_data_link_infos_url,
                              notice: 'AutomaticDataLinkInfo was successfully created.' }
                format.json { render json: @automatic_data_link_info, status: :created, location: @automatic_data_link_info }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @automatic_data_link_info.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /automatic_data_link_infos/1
    # PUT /automatic_data_link_infos/1.json
    def update
        @automatic_data_link_info = AutomaticDataLinkInfo.find(params[:id])

        respond_to do |format|
            if @automatic_data_link_info.update_attributes(params[:automatic_data_link_info])
                format.html { redirect_to automatic_data_link_infos_url,
                              notice: 'AutomaticDataLinkInfo was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
                format.html { render action: "edit" }
                format.json { render json: @automatic_data_link_info.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /automatic_data_link_infos/1
    # DELETE /automatic_data_link_infos/1.json
    def destroy
        @automatic_data_link_info = AutomaticDataLinkInfo.find(params[:id])
        @automatic_data_link_info.destroy

        respond_to do |format|
            format.html { redirect_to automatic_data_link_infos_url }
            format.json { head :no_content }
        end
    end
end
