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

get('/train/:id/edit') do
  @train = Train.find(params.fetch('id').to_i)
  erb(:train_info)
end

delete('/train/:id') do
  @train = Train.find(params.fetch('id').to_i)
  @train.delete()
  redirect to('/')
end

delete('/trains/delete') do
  Train.clear()
  redirect to('/')
end

patch('/trains/update_name/:id') do
  @train = Train.find(params.fetch('id').to_i)
  name = params.fetch('name')
  @train.update_name(name)
  erb(:train_info)
end
