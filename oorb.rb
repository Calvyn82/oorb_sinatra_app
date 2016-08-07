require 'sinatra'
require 'json'

get '/' do
  @model ={
    "content" => "Hello world"
  }.to_json
  erb :index
end
