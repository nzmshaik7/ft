class TsBandRecallsController < ApplicationController
    # GET /ts_band_recalls
    # GET /ts_band_recalls.json
    def index
        @ts_band_recalls = TsBandRecall.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @ts_band_recalls }
        end
    end

    # GET /ts_band_recalls/1
    # GET /ts_band_recalls/1.json
    def show
        @ts_band_recall = TsBandRecall.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @ts_band_recall }
        end
    end

    # GET /ts_band_recalls/new
    # GET /ts_band_recalls/new.json
    def new
        @ts_band_recall = TsBandRecall.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @ts_band_recall }
        end
    end

    # GET /ts_band_recalls/1/edit
    def edit
        @ts_band_recall = TsBandRecall.find(params[:id])
    end

    # POST /ts_band_recalls
    # POST /ts_band_recalls.json
    def create
        @ts_band_recall = TsBandRecall.new(params[:ts_band_recall])

        respond_to do |format|
            if @ts_band_recall.save
                format.html { redirect_to tsbandrecalls_url,
                              notice: 'TsBandRecall was successfully created.' }
                format.json { render json: @ts_band_recall, status: :created, location: @ts_band_recall }
            else
                format.html { render action: "new" }
                format.json { render json: @ts_band_recall.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /ts_band_recalls/1
    # PUT /ts_band_recalls/1.json
    def update
        @ts_band_recall = TsBandRecall.find(params[:id])

        respond_to do |format|
            if @ts_band_recall.update_attributes(params[:ts_band_recall])
                format.html { redirect_to tsbandrecalls_url,
                              notice: 'TsBandRecall was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @ts_band_recall.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /ts_band_recalls/1
    # DELETE /ts_band_recalls/1.json
    def destroy
        @ts_band_recall = TsBandRecall.find(params[:id])
        @ts_band_recall.destroy

        respond_to do |format|
            format.html { redirect_to ts_band_recalls_url }
            format.json { head :no_content }
        end
    end
end
