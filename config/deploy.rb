require 'bundler/capistrano'
require 'whenever/capistrano'
load 'deploy/assets'

set :application, "farmlywed"
set :repository,  "git@github.com:seankibler/wedding_invitations.git"
set :runner, "farmlywed"
set :group, "farmlywed"
set :deploy_to, "/var/www/vhosts/#{application}.com"
set :scm, :git
set :deploy_via, :remote_cache
set :whenever_command, 'bundle exec whenever'
set :user, 'root'

role :web, "do.seankibler.com"
role :app, "do.seankibler.com"
role :db,  "do.seankibler.com", :primary => true

namespace :deploy do
  task :link_database_config do
    run "rm -f #{release_path}/config/database.yml && ln -s #{shared_path}/config/database.yml #{release_path}/config/"
  end

  task :link_free_accounts do
    run "rm -f #{release_path}/config/free_account_emails.yml && ln -s #{shared_path}/config/free_account_emails.yml #{release_path}/config/"
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
before "deploy:assets:precompile", "deploy:link_database_config", "deploy:link_free_accounts", "deploy:fix_upload_permissions"
after "deploy:restart", "deploy:cleanup"
