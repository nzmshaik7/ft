desc "Check that we can access everything"
task :check_write_permissions do
  on roles(:all) do |host|
    unless test("[ -d #{fetch(:deploy_to)} ]")
      if test("mkdir -p #{fetch(:deploy_to)} ")
        info "#{fetch(:deploy_to)} created on #{host}"
      else
        error "Could not create #{fetch(:deploy_to)} on #{host}"
      end
    end
    if test("[ -w #{fetch(:deploy_to)} ]")
      info "#{fetch(:deploy_to)} is writable on #{host}"
    else
      error "#{fetch(:deploy_to)} is not writable on #{host}"
    end
  end
end
