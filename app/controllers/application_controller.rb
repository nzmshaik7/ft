class ApplicationController < ActionController::Base

    before_filter :authenticate_user!   # Devise
    protect_from_forgery
    #IF AWS force_ssl({:port => '3443'})


    def after_sign_in_path_for(resource)
        stored_location_for(resource) || userLanding
    end


    def userLanding
        if resource.is_a?(User)
            if resource.role == User::ROLE_ADMIN
                '/static/home'
            elsif resource.role == User::ROLE_CASE_MAKER
                '/static/home'
            elsif resource.role == User::ROLE_STUDENT
                '/static/home'
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

end
