require "bundler/capistrano"

load "config/recipes/base"
# load "config/recipes/rbenv"

set :application, "pearseed"
set :repository, "git@github.com:mcmorgan/#{application}.git"
set :branch, "master"

set :scm, :git

role :web, "192.168.1.132"                          # Your HTTP server, Apache/etc
role :app, "192.168.1.132"                          # This may be the same as your `Web` server

set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :bundler do
  desc "Install bundler"
  task :install, roles: :app do
    run "gem install bundler --no-ri --no-rdoc"
  end
  after "deploy:setup", "bundler:install"
end


