require "bundler/setup"
require "bundler/gem_tasks"
require "bump/tasks"
require "rake/testtask"

Rake::TestTask.new :default do |t|
  t.pattern = 'test/*_test.rb'
  t.warning = false
end
