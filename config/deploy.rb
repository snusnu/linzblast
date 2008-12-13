default_run_options[:pty] = true

set :application, "lbl"
set :domain, "lbl.snusnu.info"
set :repository,  "https://snusnu.info/svn/lbl/"

set :deploy_via, :remote_cache
set :deploy_to, "/var/www/sites/#{application}"

set :use_sudo, false

role :app,  "lbl.snusnu.info", :primary => true

# rely on ssh-agent or the likes 
# to serve our private key on authentication
ssh_options[:port] = 22
ssh_options[:username] = 'gamsl'
ssh_options[:host_key] = "ssh-rsa"
ssh_options[:auth_methods] = %w(publickey)

# workaround for capistrano-2.3 bug
ssh_options[:keys] = %w(~/.ssh/id_dsa.snusnu.info ~/.ssh/id_rsa.snusnu.info)

# call this if 'deploy_via :remote_cache' is set
# and you want to deploy a different tag or branch.
# inspired from Jonathan Weiss' explanation of the issue
# http://blog.innerewut.de/2008/3/12/remote-cache-pitfalls
task :delete_remote_cache, :roles => :app do
  run "rm -rf #{shared_path}/cached-copy"
end

desc "Watch multiple log files at the same time"
task :tail_log, :roles => :app do
  stream "tail -f #{shared_path}/log/production.log"
end
 
namespace :symlink do
  desc "Symlinks database.yml"
  task :database_yml, :roles => :app do
    run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end

namespace :deploy do
  
  desc "Restarting passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with passenger"
    task t, :roles => :app do ; end
  end
  
  desc "Runs after every successful deployment" 
  task :after_default do
    cleanup
  end
  
end

after "deploy:finalize_update", "symlink:database_yml"

# desc "recompile native gems"
# task :redeploy_gems do
#   run "cd #{latest_release}; bin/thor merb:dependencies:redeploy"
# end
# 
# after "deploy:update_code",     "redeploy_gems"