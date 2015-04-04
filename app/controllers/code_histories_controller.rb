class CodeHistoriesController < ApplicationController
    # GET /code_histories
    # GET /code_histories.json
    def index
        @code_histories = CodeHistory.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @code_histories }
        end
    end

    # GET /code_histories/1
    # GET /code_histories/1.json
    def show
        @code_history = CodeHistory.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @code_history }
        end
    end

    # GET /code_histories/new
    # GET /code_histories/new.json
    def new
        @code_history = CodeHistory.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @code_history }
        end
    end

    # GET /code_histories/1/edit
    def edit
        @code_history = CodeHistory.find(params[:id])
    end

    # POST /code_histories
    # POST /code_histories.json
    def create
        @code_history = CodeHistory.new(params[:code_history])

        respond_to do |format|
            if @code_history.save
                format.html { redirect_to codehistories_url,
                              notice: 'CodeHistory was successfully created.' }
                format.json { render json: @code_history, status: :created, location: @code_history }
            else
                format.html { render action: "new" }
                format.json { render json: @code_history.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /code_histories/1
    # PUT /code_histories/1.json
    def update
        @code_history = CodeHistory.find(params[:id])

        respond_to do |format|
            if @code_history.update_attributes(params[:code_history])
                format.html { redirect_to codehistories_url,
                              notice: 'CodeHistory was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @code_history.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /code_histories/1
    # DELETE /code_histories/1.json
    def destroy
        @code_history = CodeHistory.find(params[:id])
        @code_history.destroy

        respond_to do |format|
            format.html { redirect_to code_histories_url }
            format.json { head :no_content }
        end
    end
end
