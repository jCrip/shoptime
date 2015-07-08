# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'shoptime'
set :scm, :git
set :repo_url, 'git@github.com:jCrip/shoptime.git'
set :branch, 'master'
set :deploy_via, :copy
set :user, 'ubuntu'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/ubuntu/shoptime'

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

namespace :tasks do
  desc 'Rake assets:clean'
  task :clean do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, 'assets:clean'
          execute :touch, release_path.join('tmp/restart.txt')
        end
      end
    end
  end
end