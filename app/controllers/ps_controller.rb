class PsController < ApplicationController

    before_action :database_area, :except => [:gfnew, :gfindex, :gfedit, ]
    before_action :gf_area,       :only   => [:gfnew, :gfindex, :gfedit, ]
    include ApplicationHelper


    # GET /ps
    # GET /ps.json
    def index
        @ps = P.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @ps }
        end
    end


    # GET /ps/1
    # GET /ps/1.json
    def show
        @p = P.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @p }
        end
    end


    # GET /engine_displacements/new
    # GET /engine_displacements/new.json
    def new
        @p = P.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @p }
        end
    end


    def gfnew
        @isGroundFloor = true
        new
    end


    # GET /engine_displacements/1/edit
    def edit
        @p = P.find(params[:id])
    end


    def validateP?(edisp)
        ok = true
        edisp.name.strip!  if edisp.name
        if edisp.name.nil? or edisp.name == ''
            ok = false
            addSessionError('Name is required field.')
        end
        return ok
    end


    # POST /ps
    # POST /p.json
    def create
        @p = 
                           P.new(params.require(:p).permit(:name))
        ok = validateP?(@p)
        okUrl, errAction = setSaveAction('new', ps_url)

        respond_to do |format|
            if ok and @p.save
                format.html { redirect_to okUrl,
                      notice: 'P aka sample was successfully created.' }
                format.json { render json: @p,
                                     status: :created,
                                     location: @p }
            else
                format.html { render action: errAction }
                format.json { render json: @p.errors,
                                     status: :unprocessable_entity }
            end
        end
    end



    # PUT /ps/1
    # PUT /ps/1.json
    def update
        @p = P.find(params[:id])

        respond_to do |format|
            if @p.update_attributes(params.require(:p).permit(:name))
                format.html { redirect_to ps_url,
                      notice: 'P aka sample was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @p.errors,
                                     status: :unprocessable_entity }
            end
        end
    end


    # DELETE /ps/1
    # DELETE /ps/1.json
    def destroy
        @p = P.find(params[:id])
        @p.destroy

        respond_to do |format|
            format.html { redirect_to ps_url }
            format.json { head :no_content }
        end
    end
end