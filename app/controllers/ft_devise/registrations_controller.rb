class FtDevise::RegistrationsController < Devise::RegistrationsController

    def create
        # logger.info("==== RegistrationsController/create")
        	#sup = params[:user]
	sup = params.require(:user).permit(:email, :password, :password_confirmation,:first_name, :last_name)
	emsg = ''
        if sup[:first_name].nil? or sup[:first_name].length < 1
	    emsg = emsg + 'First Name is required.<br>'
	end
        if sup[:last_name].nil? or sup[:last_name].length < 1
	    emsg = emsg + 'Last Name is required.<br>'
	end
        if sup[:password]
            pw = sup[:password]
            if pw.length < 8
                emsg = emsg + "Your password is #{pw.length} characters; " + 
                                              "a minimum of 8 is required.<br>"
            end
            classes = 0
            classes += 1 if /[a-z]/.match(pw)
            classes += 1 if /[A-Z]/.match(pw)
            classes += 1 if /\d/.match(pw)
            classes += 1 if /[^\w\d]/.match(pw)
            if classes < 2
                emsg = emsg + "Mixed case, numbers, and/or symbols required " +
                                                              "in password.<br>"
            end

            if pw != sup[:password_confirmation]
                emsg = emsg + "Password entries do not match.<br>"
            end
        end
	if emsg == ''
	    flash[:error] = ''
	    super
	else
	    build_resource
            # No idea why this doesn't work.  Done in models/user.rb pre_create
	    # resource.role = User::ROLE_CUSTOMER
	    # resource.save
	    clean_up_passwords(resource)
	    session[:aux_error] = emsg
	    render '/ft_devise/registrations/new'
	end
    end


    def new
        super
    end

    def update
        super
    end

    protected

    # def after_sign_up_path_for(resource)
	# Not used
	# "/out/signed_up"
    # end  

    def after_inactive_sign_up_path_for(resource)
	"/static/signed_up"
    end

end
