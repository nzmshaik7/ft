# See also tasks and hooks in config/deploy.rb
# Helpful:  release_path.join('tmp/restart.txt')
# http://theadmin.org/articles/capistrano-variables/

namespace :deploy do

    # No:  set :dbympath, release_path.join('config/database.yml')
    # Yes: set :dbympath, fetch(:release_path)
    # Nil: set :dbympath, fetch(:deploy_to).join('config/database.yml')
    # set :dbympath, lambda { "#{release_path}/config/database.yml" }

    # remote_file fetch(:dbympath) => 'config/database.real', roles: :app
    
    set :holdyml, '/home/deployer/private/db.yml' 

    remote_file fetch(:holdyml) => 'config/database.real', roles: :app

    before :updated, :dbpass => fetch(:holdyml) do
	on roles(:all) do |host|
	    info ""
	    info ">>>>>>>> Fail on /home/deployer/private/db.yml is OK <<<<<<<<"
	    info ""
	    execute :mv, fetch(:holdyml), release_path.join('config/database.yml')
	    execute :chmod, '640', release_path.join('config/database.yml')
	end
    end
end
