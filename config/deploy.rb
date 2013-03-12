require 'bundler/capistrano'

set :application, "farmlywed"
set :repository,  "ssh://git@bitbucket.org/seankibler/farmlywed.git"
set :deploy_to, "/var/www/vhosts/#{application}.codingtofreedom.com"
set :scm, :git
set :deploy_via, :remote_cache

role :web, "libertas"
role :app, "libertas"
role :db,  "libertas", :primary => true


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
after "deploy:restart", "deploy:cleanup"
