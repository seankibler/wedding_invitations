require 'bundler/capistrano'

set :application, "farmlywed"
set :repository,  "ssh://git@bitbucket.org/seankibler/farmlywed.git"
set :deploy_to, "/var/www/vhosts/#{application}.libertas.com"
set :scm, :git
set :deploy_via, :remote_cache

role :app, "libertas"
role :web, "libertas"
role :db, "libertas", :primary => true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
