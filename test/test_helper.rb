ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require File.expand_path '../../oorb.rb', __FILE__
require File.expand_path '../../lib/json_builder.rb', __FILE__
