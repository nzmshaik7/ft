class TopController < ApplicationController

    include ApplicationHelper

    def db
        return  unless roleValid?([User::ROLE_ADMIN], 'database administration')
        @colorZone = 'DB'
    end
    def analytics
        return  unless roleValid?([User::ROLE_ADMIN], 'analytics')
    end
    def creds
        return  unless roleValid?([User::ROLE_ADMIN], 'credentials')
    end
    def gf
        return  unless roleValid?([User::ROLE_ADMIN], 'ground floor')
    end
end
