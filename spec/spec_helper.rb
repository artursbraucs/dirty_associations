$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dirty_nested_attributes'

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
