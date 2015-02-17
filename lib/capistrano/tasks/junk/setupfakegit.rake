desc "Set up a mirrored temporary git repo on the deployment server"
task :setupfakegit do
    on roles(:all) do |host|
	unless test("[ -d #{fetch(:deploy_to)}/shared ]")
	    if test("mkdir -p #{fetch(:deploy_to)}/shared ]")
		info "#{fetch(:deploy_to)}/shared created on #{host}"
	    else
		error "Could not create #{fetch(:deploy_to)}/shared on #{host}"
	    end
	end
	info "Run #{fetch(:deploy_to)}/shared/setupgit.sh as root on #{host}"
    end
end
