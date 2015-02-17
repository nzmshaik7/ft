namespace :deploy do
  namespace :anoothercheck do
    task :check_write_permissions => 'config/newrelic.yml'
  end
end

remote_file 'config/newrelic.yml' => '/tmp/newrelic.yml', roles: :app

file '/tmp/newrelic.yml' do |t|
  sh "curl -o #{t.name} https://rpm.newrelic.com/accounts/xx/newrelic.yml"
end
