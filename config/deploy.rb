require 'bundler/capistrano'
load 'deploy/assets'

set :application, "farmlywed"
set :repository,  "ssh://git@bitbucket.org/seankibler/farmlywed.git"
set :runner, "farmlywed"
set :group, "farmlywed"
set :deploy_to, "/var/www/vhosts/#{application}.codingtofreedom.com"
set :scm, :git
set :deploy_via, :remote_cache

role :web, "libertas"
role :app, "libertas"
role :db,  "libertas", :primary => true


namespace :deploy do
  task :link_database_config do
    run "rm -f #{release_path}/config/database.yml && ln -s #{shared_path}/config/database.yml #{release_path}/config/"
  end

  task :fix_upload_permissions do
    run "chown -R #{runner}:#{group} #{release_path}"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
after "deploy:update", "deploy:link_database_config"
after "deploy:update_code", "deploy:fix_upload_permissions"
after "deploy:restart", "deploy:cleanup"
