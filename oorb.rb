require 'sinatra'
require 'json'
require_relative 'lib/json_builder'

get '/' do
  @model ={
    "content" => JSONBuilder.new.build
  }.to_json
  erb :index
end
