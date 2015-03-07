class StaticController < ApplicationController

    skip_before_filter :authenticate_user!

    def home
    end
    def signed_up
    end
end
