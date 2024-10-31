name = "ar_multi_threaded_transactional_tests"
$LOAD_PATH << File.expand_path('../lib', __FILE__)
require "#{name.gsub("-","/")}/version"

Gem::Specification.new name, ArMultiThreadedTransactionalTests::VERSION do |s|
  s.summary = "Execute multithreaded code while still using transactional fixtures by synchronizing db access to a single connection"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files lib/ bin/ MIT-LICENSE`.split("\n")
  s.license = "MIT"
  s.required_ruby_version = '>= 3.1.0'
  s.add_runtime_dependency 'activerecord', '>= 6.1.0', '< 7.2.0'
  s.add_development_dependency "bump"
  s.add_development_dependency "rake"
  s.add_development_dependency "maxitest"
  s.add_development_dependency "single_cov"
  s.add_development_dependency "sqlite3"
end
