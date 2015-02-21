desc "Set up a mirrored temporary git repo on the deployment server"

namespace :setupgit do
    task :setupfakegit do
	on roles(:all) do |host|
	    unless test("[ -d #{fetch(:deploy_to)}/shared ]")
		if test("mkdir -p #{fetch(:deploy_to)}/shared ]")
		    info "#{fetch(:deploy_to)}/shared created on #{host}"
		else
		    error "Create #{fetch(:deploy_to)}/shared failed on #{host}"
		end
	    end
	    # If the file is already in place, it will not get updated.  Duh.
	    if test("[ -f #{fetch(:deploy_to)}/shared/setupgit.sh ]")
	        execute :rm, "#{fetch(:deploy_to)}/shared/setupgit.sh"
	    end
	    invoke "setupgit:fakegit4"
	    invoke "setupgit:fakegit9"
	end
    end

    remote_file 'setupgit.sh' => 'script/setupgit.sh', roles: :all
    remote_file '/tmp/dlaw-clpe.pub' => 'script/dlaw-clpe.pub', roles: :all

    task :fakegit4 => '/tmp/dlaw-clpe.pub' do
	on roles(:all) do |h|
	    info "Copy public key on #{h}"
	end
    end

    task :fakegit9 => 'setupgit.sh' do
	set :scr, "#{fetch(:deploy_to)}/shared/setupgit.sh"
	on roles(:all) do |h|
	    info "(failed status on /home/deployer/ft/shared/setupgit.sh is OK)"
	    info "***"
	    info "*** Run #{fetch(:scr)} as root on #{h} ***"
	    info "***"
	end
    end
end
