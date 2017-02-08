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
  s.required_ruby_version = '>= 2.1.0'
end
