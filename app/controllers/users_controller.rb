class UsersController < ApplicationController

    include ApplicationHelper


    def setRolesForm(u)
        @roles = { 'Select' => 0 }
        for r in User::ALL_ROLES
            @roles[u.roleText(r)] = r
        end
        # @roles = { "Select" => 0, "Admin" => 11, "Clerk" => 12 }
        if u.role
            @selectedRole = u.role
        else
            @selectedRole = 0
        end
    end


    # GET /users
    # GET /users.json
    def index
        return  unless roleValid?([User::ROLE_ADMIN], 'user administration')
        @users = User.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @users }
        end
    end


    # GET /users/1
    # GET /users/1.json
    def show
        return  unless roleValid?([User::ROLE_ADMIN], 'user administration')
        @user = User.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @user }
        end
    end


    # GET /users/new
    # GET /users/new.json
    def new
        return  unless roleValid?([User::ROLE_ADMIN], 'user administration')
        @user = User.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @user }
        end
    end


    # GET /users/1/edit
    def edit
        return  unless roleValid?([User::ROLE_ADMIN], 'user administration')
        @user = User.find(params[:id])
        setRolesForm(@user)
    end


    # POST /users
    # POST /users.json
    # Devise user creation does not come here.
    # See FtDevise::RegistrationsController#create
    def create
        return  unless roleValid?([User::ROLE_ADMIN], 'user administration')
        @user = User.new(params[:user])
        setRolesForm(@user)
        @user.role = User::ROLE_CUSTOMER

        respond_to do |format|
            if @user.save
                format.html { redirect_to @user,
                              notice: 'User was successfully created.' }
                format.json { render json: @user,
                              status: :created, location: @user }
            else
                format.html { render action: "new" }
                format.json { render json: @user.errors,
                              status: :unprocessable_entity }
            end
        end
    end


    # PUT /users/1
    # PUT /users/1.json
    def update
        return  unless roleValid?([User::ROLE_ADMIN], 'user administration')
        # logger.info("=== params: #{params.inspect}")
        @user = User.find(params[:id])

        respond_to do |format|
            if @user.update_attributes(params[:user])
                format.html { redirect_to users_url,
                              notice: 'User was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @user.errors,
                              status: :unprocessable_entity }
            end
        end
    end


    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
        return  unless roleValid?([User::ROLE_ADMIN], 'user administration')
        @user = User.find(params[:id])
        @user.destroy

        respond_to do |format|
            format.html { redirect_to users_url }
            format.json { head :no_content }
        end
    end
end
