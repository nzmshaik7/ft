class TopController < ApplicationController

    include ApplicationHelper

    def db
        return  unless roleValid?([User::ROLE_ADMIN], 'database administration')
    end
end
