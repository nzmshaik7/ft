class TopController < ApplicationController

    before_filter :gf_area, :only => [:gf, ]
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
    def files
        return  unless roleValid?([User::ROLE_MOCKER], 'files')
    end
    def file1
        return  unless roleValid?([User::ROLE_MOCKER], 'files')
        send_file '/tmp/dump.Oct08.sql'
    end
end
