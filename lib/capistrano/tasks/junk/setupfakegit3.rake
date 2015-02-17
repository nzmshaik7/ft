namespace :setupfakegit3 do

    task :placefile => 'setupgit.sh' do
	on roles(:all) do |h|
	    info "Run #{fetch(:deploy_to)}/shared/setupgit.sh as root on #{h}"
	end
    end

    desc "Set up a mirrored temporary git repo on the deployment server"
    task :main do
	after :finishing, :placefile
	on roles(:all) do |host|
	    unless test("[ -d #{fetch(:deploy_to)}/shared ]")
		if test("mkdir -p #{fetch(:deploy_to)}/shared ]")
		    info "#{fetch(:deploy_to)}/shared created on #{host}"
		else
		    error "Create #{fetch(:deploy_to)}/shared failed on #{host}"
		end
	    end
	end
    end

    remote_file 'setupgit.sh' => 'script/setupgit.sh', roles: :all

end
