module ApplicationHelper

    def addFlashError(msg)
        if flash[:error].nil?
            flash[:error] = msg
            return
        end
        unless flash[:error].index(msg).nil?
            return
        end
        flash[:error] += "<br>" + msg
    end


    def roleValid?(roleList, area = nil)
        if area.nil?
            area = 'that area'
        else
            area = 'the ' + area + ' area'
        end
        if user_signed_in?
            @user = current_user
        else
            # Should never happen.
            addFlashError("You must be logged in to access #{area}.")
            redirect_to :action => 'sign_in', :controller => 'users'
            logger.info("==== role invalid, not signed in")
            return false
        end
        if roleList.include?(@user.role)
            return true
        else
            # addFlashError("You are not authorized to access #{area}.")
            # flash.keep(:error)
            session[:role_error] = area
            redirect_to '/static/home'
            logger.info("==== role #{@user.role} not valid here")
            return false
        end
    end

end
