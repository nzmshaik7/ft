class FinanceAgreementsController < ApplicationController

    before_filter :database_area

    # GET /finance_agreements
    # GET /finance_agreements.json
    def index
        @finance_agreements = FinanceAgreement.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @finance_agreements }
        end
    end

    # GET /finance_agreements/1
    # GET /finance_agreements/1.json
    def show
        @finance_agreement = FinanceAgreement.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @finance_agreement }
        end
    end

    # GET /finance_agreements/new
    # GET /finance_agreements/new.json
    def new
        @finance_agreement = FinanceAgreement.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @finance_agreement }
        end
    end

    # GET /finance_agreements/1/edit
    def edit
        @finance_agreement = FinanceAgreement.find(params[:id])
    end

    # POST /finance_agreements
    # POST /finance_agreements.json
    def create
        @finance_agreement = FinanceAgreement.new(params[:finance_agreement])

        respond_to do |format|
            if @finance_agreement.save
                format.html { redirect_to finance_agreements_url,
                              notice: 'FinanceAgreement was successfully created.' }
                format.json { render json: @finance_agreement, status: :created, location: @finance_agreement }
            else
                format.html { render action: "new" }
                format.json { render json: @finance_agreement.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /finance_agreements/1
    # PUT /finance_agreements/1.json
    def update
        @finance_agreement = FinanceAgreement.find(params[:id])

        respond_to do |format|
            if @finance_agreement.update_attributes(params[:finance_agreement])
                format.html { redirect_to finance_agreements_url,
                              notice: 'FinanceAgreement was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @finance_agreement.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /finance_agreements/1
    # DELETE /finance_agreements/1.json
    def destroy
        @finance_agreement = FinanceAgreement.find(params[:id])
        @finance_agreement.destroy

        respond_to do |format|
            format.html { redirect_to finance_agreements_url }
            format.json { head :no_content }
        end
    end
end
