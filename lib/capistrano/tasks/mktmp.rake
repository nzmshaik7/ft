namespace :deploy do
    after :publishing, :mktmp do
	on roles(:all) do |host|
	    execute :mkdir, "-p", "#{fetch(:deploy_to)}/current/tmp"
	end
    end
end
