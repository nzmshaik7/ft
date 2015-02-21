namespace :cache do
  desc "Stub found at http://stackoverflow.com/questions/19017983/what-is-the-difference-between-rails-cache-clear-and-rake-tmpcacheclear"
  task :clear => :environment do
    FileUtils.rm_rf(Dir['tmp/cache/[^.]*'])
  end
end
