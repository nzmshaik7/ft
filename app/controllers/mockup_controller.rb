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

end
