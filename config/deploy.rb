lock '3.12.0'

set :application, 'pfcdotcom'

set :repo_url,  'git@github.com:tiphp452/pfcdotcom.git'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.6.6'

set :linked_files, fetch(:linked_files, []).push("config/master.key")

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/my-key.pem'] 

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end