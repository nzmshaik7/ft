class StaticController < ApplicationController

    skip_before_filter :authenticate_user!
    layout "anim", :only => [:home]

    def home
    end
    def signed_up
    end
end
