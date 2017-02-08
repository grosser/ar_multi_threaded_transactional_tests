require "bundler/setup"

require "single_cov"
SingleCov.setup :minitest

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "ar_multi_threaded_transactional_tests/version"
require "ar_multi_threaded_transactional_tests"

require_relative 'database'
require 'maxitest/autorun'
