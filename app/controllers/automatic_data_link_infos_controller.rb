class AutomaticDataLinkInfosController < ApplicationController
    # GET /automatic_data_link_infos
    # GET /automatic_data_link_infos.json
    def index
        @automatic_data_link_infos = AutomaticDataLinkInfo.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @automatic_data_link_infos }
        end
    end

    # GET /automatic_data_link_infos/1
    # GET /automatic_data_link_infos/1.json
    def show
        @automatic_data_link_info = AutomaticDataLinkInfo.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @automatic_data_link_info }
        end
    end

    # GET /automatic_data_link_infos/new
    # GET /automatic_data_link_infos/new.json
    def new
        @automatic_data_link_info = AutomaticDataLinkInfo.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @automatic_data_link_info }
        end
    end

    # GET /automatic_data_link_infos/1/edit
    def edit
        @automatic_data_link_info = AutomaticDataLinkInfo.find(params[:id])
    end

    # POST /automatic_data_link_infos
    # POST /automatic_data_link_infos.json
    def create
        @automatic_data_link_info = AutomaticDataLinkInfo.new(params[:automatic_data_link_info])

        respond_to do |format|
            if @automatic_data_link_info.save
                format.html { redirect_to automaticdatalinkinfos_url,
                              notice: 'AutomaticDataLinkInfo was successfully created.' }
                format.json { render json: @automatic_data_link_info, status: :created, location: @automatic_data_link_info }
            else
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
                format.html { redirect_to automaticdatalinkinfos_url,
                              notice: 'AutomaticDataLinkInfo was successfully updated.' }
                format.json { head :no_content }
            else
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
