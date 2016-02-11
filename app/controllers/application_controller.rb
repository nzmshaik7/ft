class ApplicationController < ActionController::Base

    before_filter :authenticate_user!   # Devise
    protect_from_forgery
    #IF AWS force_ssl({:port => '3443'})


    def after_sign_in_path_for(resource)
        stored_location_for(resource) || userLanding
    end


    def userLanding
        if user_signed_in?
            @user = current_user
            if @user.role == User::ROLE_DATAENT
                return '/top/gf'
            end
        end

        # Always false.  resource is nil on signin.
        if resource.is_a?(User)
            if resource.role == User::ROLE_ADMIN
                '/static/home'
            elsif resource.role == User::ROLE_MOCKER
                '/static/home'
            elsif resource.role == User::ROLE_DATAENT
                '/top/gf'
            else
                '/static/home'
            end
        else
            '/static/home'
        end
    end


    def after_sign_out_path_for(resource)
        '/users/sign_in'
    end

protected

    # http://guides.rubyonrails.org/action_controller_overview.html#filters
    def only_allow(area, roleList)
        if user_signed_in?
            @user = current_user
        else
            # Should never happen.
            addFlashError("You must be logged in to access #{area}.")
            redirect_to :action => 'sign_in', :controller => 'users'
            logger.info("==== only_allow redirect, not signed in")
        end
        if not roleList.include?(@user.role)
            # addFlashError("You are not authorized to access #{area}.")
            # flash.keep(:error)
            session[:role_error] = area
            redirect_to '/static/home'
            logger.info("==== role #{@user.role} not valid in #{area}")
        end
    end


    def database_area
        # only_allow_admins
        only_allow('the administration area', [User::ROLE_ADMIN])
        @colorZone = 'DB'
    end


    def gf_area
        only_allow('the data entry area',
                   [User::ROLE_ADMIN, User::ROLE_DATAENT])
        @colorZone = 'GF'
    end

end
