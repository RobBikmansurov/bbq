# config valid for current version and patch releases of Capistrano
lock '~> 3.14.1'

set :application, 'bbq'
set :repo_url, 'git@github.com:RobBikmansurov/bbq.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
## set :deploy_to, '/var/www/html/bbq'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/master.key', 'config/credentials.yml.enc'
append :linked_files, 'config/master.key', 'config/database.yml'
# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# capistrano/rbenv
set :rbenv_type, :user # or :system, or :fullstaq (for Fullstaq Ruby), depends on your rbenv setup
set :rbenv_ruby, '2.7.1'

# in case you want to set ruby version from the file:
# set :rbenv_ruby, File.read('.ruby-version').strip

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all # default value

# capistrano/bundler
append :linked_dirs, '.bundle'

set :bundle_roles, :all                                         # this is default
set :bundle_config, { deployment: true }                        # this is default
set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
set :bundle_binstubs, -> { shared_path.join('bin') }            # default: nil
set :bundle_gemfile, -> { release_path.join('Gemfile') } # default: nil
set :bundle_path, -> { shared_path.join('bundle') }             # this is default. set it to nil to use bundler's default path
set :bundle_without, %w[development test].join(' ')             # this is default
set :bundle_flags, '--quiet'                                    # this is default
set :bundle_env_variables, {}                                   # this is default
set :bundle_clean_options, ''                                   # this is default. Use "--dry-run" if you just want to know what gems would be deleted, without actually deleting them
set :bundle_check_before_install, true # default: true. Set this to false to bypass running `bundle check` before executing `bundle install`

set :bundle_jobs, 2 # default: 4, only available for Bundler >= 1.4
set :bundle_binstubs, -> { shared_path.join('bin') }

# after "deploy:restart", "resque:restart"

