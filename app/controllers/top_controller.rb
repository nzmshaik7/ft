class TopController < ApplicationController

    include ApplicationHelper

    def db
        return  unless roleValid?([User::ROLE_ADMIN], 'database administration')
    end
    def analytics
        return  unless roleValid?([User::ROLE_ADMIN], 'analytics')
    end
end
