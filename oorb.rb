require 'sinatra'
require 'json'
require_relative 'lib/json_builder'

get '/' do
  @model ={
    "jsonData"        => JSONBuilder.new.build,
    "textBoxContents" => "Type here",
    "output"          => "This is where your regex will appear."
  }.to_json
  erb :index
end
