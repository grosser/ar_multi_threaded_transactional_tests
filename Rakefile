require "bundler/setup"
require "bundler/gem_tasks"
require "bump/tasks"
require "rake/testtask"

Rake::TestTask.new :default do |t|
  t.pattern = 'test/*_test.rb'
  t.warning = false
end

desc 'Bundle all gemfiles CMD=install'
task :bundle_all do
  Bundler.with_original_env do
    Dir['gemfiles/*.gemfile'].each do |gemfile|
      sh "BUNDLE_GEMFILE=#{gemfile} bundle #{ENV["CMD"]}"
    end
  end
end
