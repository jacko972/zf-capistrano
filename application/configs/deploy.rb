set :application, "zf-capistrano"
set :deploy_to, "/var/www/#{application}"
default_run_options[:pty] = true

set :scm, :git
set :repository,  "git@github.com:memphys/zf-capistrano.git"
set :deploy_via, :remote_cache
set :branch, "master"
set :keep_releases, 3

server "107.22.224.149", :app, :web, :db, :primary => true
set :ssh_options, {:forward_agent => true, :port => 22}
set :user, "deployer"
set :use_sudo, false

namespace :deploy do

    task :start do
    end

    task :stop do
    end

    task :migrate do
    end

    task :restart do
    end

end

namespace :myproject do

    task :symlink, :roles => :app do
        run "mkdir -p #{shared_path}/library"
        run "chmod -R 755 #{shared_path}/library"
        run "ln -nfs /usr/local/ZendFramework-1.11.11/library/Zend #{shared_path}/library/Zend"
        run "ln -nfs #{shared_path}/library #{release_path}/library"
    end

    task :uploads, :roles => :app do
        run "mkdir -p #{shared_path}/public/uploads"
        run "chmod -R 775 #{shared_path}/public/uploads"
        run "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
    end

end

after "deploy:symlink", "myproject:symlink", "myproject:uploads"