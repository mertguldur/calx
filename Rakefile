# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

require 'rubocop/rake_task'
require 'coveralls/rake/task'

CalX::Application.load_tasks
RuboCop::RakeTask.new
Coveralls::RakeTask.new

Rake::Task[:default].prerequisites.clear
task default: [:rubocop, :spec, :cucumber, 'coveralls:push']
