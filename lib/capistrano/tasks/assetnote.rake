namespace :deploy do

    after :updating, :assetnote do
	on roles(:all) do |host|
	    info ""
	    info ">>>>>>>> 2 fails on public/assets tests are OK <<<<<<<<"
	    info ""
	end
    end
end
