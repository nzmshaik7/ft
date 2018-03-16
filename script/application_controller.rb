class ApplicationController < ActionController::Base
  protect_from_forgery
  options[:port] = '3443'
  force_ssl options
end
