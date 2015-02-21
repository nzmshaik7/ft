# See also tasks and hooks in config/deploy.rb
# Helpful:  release_path.join('tmp/restart.txt')

namespace :deploy do
    after :publishing, :mktmp do
	on roles(:all) do |host|
	    execute :mkdir, "-p", "#{fetch(:deploy_to)}/current/tmp"
	end
    end
end
