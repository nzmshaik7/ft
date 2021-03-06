module ApplicationHelper

    ValidEmailPatt =
       Regexp.new("([a-zA-Z0-9+_\.\-]+@[0-9a-zA-Z][\.0-9a-z_A-Z-]*\.[a-zA-Z]+)")
    ValidPhonePatt = Regexp.new("^([\(\)0-9\.x -]+)$")


    def emailValid?(email)
        if ValidEmailPatt =~ email
            return true
        end
        return false
    end


    def phoneValid?(ph)
        if ValidPhonePatt =~ ph and ph.length >= 7
            return true
        end
        return false
    end


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


    def addSessionError(msg)
        if session[:aux_error].nil?
            session[:aux_error] = msg
            return
        end
        unless session[:aux_error].index(msg).nil?
            return
        end
        session[:aux_error] += "<br>" + msg
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

    def boolText(b)
        if b.nil?
            return 'No'
        end
        if not b
            return 'No'
        end
        return 'Yes'
    end


    # True if params contains signal that ground floor is in effect.
    #
    def formHasGf?
        if params.has_key?('is_ground_floor') and 
                                              params[:is_ground_floor] == 'Y'
            return true
        end
        return false
    end


    # This lets your multipath different sequences of forms through
    # the same action.  It sets up the different turns depending on
    # what level of interface you are on (basement or ground floor).
    #
    def setSaveAction(act, url)
        if formHasGf?
            okUrl = '/top/gf'
            errAction = 'gf' + act
            @isGroundFloor = true
            @colorZone = 'GF'
        else
            okUrl = url
            errAction = act
        end
        return okUrl, errAction
    end


    def prepDateCollects(yearFuture = 0)
        now = Time.now

        @monthsCollect = Array.new
        for mn in 1 .. 12
            mtime = Time.local(2000, mn, 15, 1, 1, 1)
            @monthsCollect.push([ mtime.strftime("%b"), mtime.mon ])
        end
        @selStMonth = 1
        @selEnMonth = 12

        @daysCollect = Array.new
        for dy in 1 .. 31
            @daysCollect.push([ dy, dy ])
        end
        @selStDay = 1
        @selEnDay = 1

        @yearsCollect = Array.new
        thisYear = Time.now.year
        for yr in thisYear - 15 .. thisYear + yearFuture
            @yearsCollect.push([ yr, yr ])
        end
        @selStYear = thisYear
        @selEnYear = thisYear
    end

end
