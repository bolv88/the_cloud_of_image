require "rvm/capistrano"
require "bundler/capistrano"
set :rvm_type, :system

set :application, "the_cloud_of_images"
set :repository,  "https://github.com/bolv88/the_cloud_of_image.git"

set :stage, "product"

set :deploy_to,   "/u/apps/#{application}/"

set :scm, :git

set :user, "root"

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "blublu.me"                          # Your HTTP server, Apache/etc

#role :app, "Apache"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"


#set :deploy_via, :remote_cache

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

