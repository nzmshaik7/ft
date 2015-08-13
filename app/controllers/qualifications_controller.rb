class QualificationsController < ApplicationController

    before_filter :database_area
    include QualificationsHelper

    def prepFormVariables(qual)
        @serviceVisits = ServiceVisit.all
        @serviceVisitCollect = @serviceVisits.collect { |p|
            [ p.visitText, p.id ] 
        }
        prepCylinders(qual, 10)
    end

    # GET /qualifications
    # GET /qualifications.json
    def index
        @qualifications = Qualification.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @qualifications }
        end
    end

    # GET /qualifications/1
    # GET /qualifications/1.json
    def show
        @qualification = Qualification.find(params[:id])
        prepFormVariables(@qualification)

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @qualification }
        end
    end

    # GET /qualifications/new
    # GET /qualifications/new.json
    def new
        @qualification = Qualification.new
        prepFormVariables(@qualification)

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @qualification }
        end
    end

    # GET /qualifications/1/edit
    def edit
        @qualification = Qualification.find(params[:id])
        prepFormVariables(@qualification)
    end

    # Run through what we have and what is on the form.  Resolve
    # any discrepancies.
    #
    def saveCompressions(qual)
        for cn in 1..12
            keyid = "qual_cyl_#{ cn }"
            if params.has_key?(keyid)
                if params[keyid].to_i > 0
                    # At this point we have a valid PSI for a cyl from
                    # the form.  See if we can find it in the DB.
                    found = false
                    for cc in qual.cylinder_compressions
                        if cc.cyl_num == cn
                            found = true
                            if cc.psi != params[keyid].to_i
                                cc.psi = params[keyid].to_i
                                cc.save
                            end
                        end
                    end
                    if not found
                        newcc = CylinderCompression.new
                        newcc.qualification_id = qual.id
                        newcc.cyl_num = cn
                        newcc.psi = params[keyid].to_i
                        newcc.save
                    end
                end
            end
        end
    end

    # POST /qualifications
    # POST /qualifications.json
    def create
        @qualification = Qualification.new(params[:qualification])
        if @qualification.save
            saveCompressions(@qualification)
            ok = true
        else
            ok = false
        end

        respond_to do |format|
            if ok
                format.html { redirect_to qualifications_url,
                              notice: 'Qualification was successfully created.' }
                format.json { render json: @qualification, status: :created, location: @qualification }
            else
                prepFormVariables(@qualification)
                format.html { render action: "new" }
                format.json { render json: @qualification.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /qualifications/1
    # PUT /qualifications/1.json
    def update
        @qualification = Qualification.find(params[:id])
        saveCompressions(@qualification)

        respond_to do |format|
            if @qualification.update_attributes(params[:qualification])
                format.html { redirect_to qualifications_url,
                              notice: 'Qualification was successfully updated.' }
                format.json { head :no_content }
            else
                prepFormVariables(@qualification)
                format.html { render action: "edit" }
                format.json { render json: @qualification.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /qualifications/1
    # DELETE /qualifications/1.json
    def destroy
        @qualification = Qualification.find(params[:id])
        for cc in @qualification.cylinder_compressions
            cc.destroy
        end
        @qualification.destroy

        respond_to do |format|
            format.html { redirect_to qualifications_url }
            format.json { head :no_content }
        end
    end
end
