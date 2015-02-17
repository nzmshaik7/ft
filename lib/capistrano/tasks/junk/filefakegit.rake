task :setupfakegit => 'setupgit.sh'
remote_file 'setupgit.sh' => 'script/setupgit.sh', roles: :all
