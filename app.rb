require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/train'
require './lib/timetable'
require './lib/stop'
require 'pg'

DB = PG.connect({:dbname => "train_sql"})

get ('/') do
  erb(:index)
end
post ('/add_train') do
  name = params.fetch('name')
  train = Train.new({:name => name})
  train.save()
  @trains = Train.all()
  erb(:result)
end

get('/train/:id') do
  @train = Train.find(params.fetch('id').to_i)
  erb(:train_info)
end
