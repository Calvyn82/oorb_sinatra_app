require 'sass/plugin/rack'
require './oorb'

use Sass::Plugin::Rack

run Sinatra::Application
