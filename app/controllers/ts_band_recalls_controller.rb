class TsBandRecallsController < ApplicationController

    before_filter :only_allow_admins

    def prepFormVariables
        @vehicles = Vehicle.all
        @vehicleCollect = @vehicles.collect { |p|
            [ p.ymmpText, p.id ] 
        }
    end


    def formPostUpdate(ts_band_recall)
        # At this point, it is the same as the create case.
        # For update, this will get done twice - the validate is
        # at waste for now, since nothing is actually validated.
        validateLoad(ts_band_recall)
    end

    def validateLoad(ts_band_recall)
        if params[:tsb_recall_completed]
            # Date value will get set.
        else
            ts_band_recall.date_completed = nil
        end
    end

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
        prepFormVariables

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @ts_band_recall }
        end
    end

    # GET /ts_band_recalls/new
    # GET /ts_band_recalls/new.json
    def new
        @ts_band_recall = TsBandRecall.new
        prepFormVariables

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @ts_band_recall }
        end
    end

    # GET /ts_band_recalls/1/edit
    def edit
        @ts_band_recall = TsBandRecall.find(params[:id])
        prepFormVariables
    end

    # POST /ts_band_recalls
    # POST /ts_band_recalls.json
    def create
        @ts_band_recall = TsBandRecall.new(params[:ts_band_recall])
        validateLoad(@ts_band_recall)

        respond_to do |format|
            if @ts_band_recall.save
                format.html { redirect_to ts_band_recalls_url,
                          notice: 'TSB and Recall was successfully created.' }
                format.json { render json: @ts_band_recall, status: :created, location: @ts_band_recall }
            else
                prepFormVariables
                format.html { render action: "new" }
                format.json { render json: @ts_band_recall.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /ts_band_recalls/1
    # PUT /ts_band_recalls/1.json
    def update
        @ts_band_recall = TsBandRecall.find(params[:id])
        validateLoad(@ts_band_recall)

        respond_to do |format|
            if @ts_band_recall.update_attributes(params[:ts_band_recall])

                # DLAW FIXME - this is a double save
                #
                formPostUpdate(@ts_band_recall)
                @ts_band_recall.save

                format.html { redirect_to ts_band_recalls_url,
                              notice: 'TSB and Recall was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables
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
