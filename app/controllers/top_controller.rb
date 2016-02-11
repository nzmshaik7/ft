class TopController < ApplicationController

    # before_filter :gf_area, :only => [:gf, ]
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
        gf_area
    end
    def files
        return  unless roleValid?([User::ROLE_MOCKER], 'files')
    end
    def file1
        return  unless roleValid?([User::ROLE_MOCKER], 'files')
        send_file '/tmp/dump.Oct08.sql'
    end
    def file2
        return  unless roleValid?([User::ROLE_MOCKER], 'files')
        send_file '/home/rails/ft/db/DatabaseLatest.txt'
    end
    def cygwin1
        return  unless roleValid?([User::ROLE_ADMIN], 'files')
        send_file '/home/rails/ft/app/assets/binaries/cygwin1.dll'
    end
    def openmawiki
        return  unless roleValid?([User::ROLE_ADMIN], 'files')
        send_file '/home/rails/ft/app/assets/binaries/openmawiki.exe'
    end
end
