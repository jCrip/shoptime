# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'shoptime'
set :scm, :git
set :repo_url, 'git@example.com:me/my_repo.git'
set :branch, 'master'
set :deploy_via, :copy
set :user, 'ubuntu'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/ubuntu/apps/shoptime'

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

