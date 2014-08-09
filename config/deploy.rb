# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'xiguashe'
set :repo_url, 'git@git.oschina.net:wikimo/xiguashe.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/wwwroot/www.xiguashe.com'

# Default value for :scm is :git
set :scm, :git
set :branch, 'devel'
# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/thin.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{script log tmp/pids tmp/cache}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :rvm_ruby_version, '1.9.3'
set :rvm_ruby_version, '1.9.3@3.2'

namespace :deploy do

  task :config_nginx do
    on roles(:app) do
      paths = capture "grep deployed #{deploy_to}/revisions.log | tail -n 2 | cut -d' ' -f8"
      pre = paths.split("\n").first
      current = paths.split("\n").last
      execute "sed -i  's/#{pre}/#{current}/g' /usr/local/nginx/conf/vhost/www.xiguashe.com.conf" 
    end

    puts 'config nginx..'
  end

  task :restart_thin_server do
    on roles(:app) do
       thin_pids = capture "ps -ef | grep xiguashe-thin  | grep -v grep  | awk {'print $2'}"
       execute "ps -ef | grep xiguashe-thin  | grep -v grep  | awk {'print $2'}  | xargs kill -9" if thin_pids.length > 0

       paths = capture "grep deployed #{deploy_to}/revisions.log | tail -n 2 | cut -d' ' -f8"
       pre_path = paths.split("\n").first
       pre_path = "#{deploy_to}/releases/#{pre_path}"

       release_path = paths.split("\n").last
       release_path = "#{deploy_to}/releases/#{release_path}"
       # start thin
       execute "cd #{release_path}; bundle exec thin start -C config/thin.yml -p 8000"
       
      end

    puts 'restart thin server...'
  end

  task :reload_nginx do
    on roles(:app) do
      execute " nginx -s reload"
    end
    puts "reload nginx..."
  end

end


after :deploy, "deploy:restart_thin_server"
after 'deploy:restart_thin_server', 'deploy:config_nginx'
after 'deploy:config_nginx','deploy:reload_nginx'
