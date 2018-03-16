class MockupController < ApplicationController

    include ApplicationHelper
    ALLOWED_ROLES = [User::ROLE_ADMIN, User::ROLE_MOCKER]

    

    def internal_veh
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def multi_veh
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def customer_veh
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def store
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def softwareprinc
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def contract
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def classifications
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def insurance
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def videoTestm
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def writtenTestm
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def contract
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def sixgas
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def alighmentReport
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def classifications
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def insurance
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def loanAgrmnt
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def nonMaMaint
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def paymentAgrmnt
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def qualReport
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def spectrum
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def videoTestm
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def vinDecode
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def vwmaint1
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def vwmaint2
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def vwmaint3
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def writtenTestm
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def bgPaper
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end

    def basic
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end
    
    def pie
        return  unless roleValid?(ALLOWED_ROLES, 'mockup')
    end
    
    def bar
        
	
	@parts = Part.find(3)
	return
	
	
    end

    



end
