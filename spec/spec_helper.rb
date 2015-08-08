$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dirty_associations'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
