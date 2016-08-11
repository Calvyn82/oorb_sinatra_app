require 'sinatra'
require 'json'
require 'erb'
require 'sass'
require_relative 'lib/json_builder'

configure do
  set :scss, {style: :compressed}
end

get '/css/:name.css' do |name|
  content_type :css
  scss "sass/#{name}".to_sym, layout: false
end

get '/' do
  @model ={
    "jsonData"        => JSONBuilder.new.build,
    "textBoxContents" => "Type here",
    "output"          => "This is where your regex will appear."
  }.to_json
  erb :index
end
