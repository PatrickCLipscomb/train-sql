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
# Begin Code for Trains
post ('/add_train') do
  name = params.fetch('name')
  train = Train.new({:name => name})
  train.save()
  @trains = Train.all()
  @stops = Stop.all()
  @timetables = Timetable.all()
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
# Begin Code for Stops
post ('/add_stop') do
  name = params.fetch('name')
  stop = Stop.new({:name => name})
  stop.save()
  @stops = Stop.all()
  @trains = Train.all()
  @timetables = Timetable.all()
  erb(:result)
end
get('/stop/:id/edit') do
  @stop = Stop.find(params.fetch('id').to_i)
  erb(:stop_info)
end
delete('/stop/:id') do
  @stop = Stop.find(params.fetch('id').to_i)
  @stop.delete()
  redirect to('/')
end
delete('/stops/delete') do
  Stop.clear()
  redirect to('/')
end
patch('/stops/update_name/:id') do
  @stop = Stop.find(params.fetch('id').to_i)
  name = params.fetch('name')
  @stop.update_name(name)
  erb(:stop_info)
end
# Begin Code for Timetables
post ('/add_timetable') do
  name = params.fetch('name')
  timetable = Timetable.new({:name => name})
  timetable.save()
  @timetables = Timetable.all()
  @trains = Train.all()
  @stops = Stop.all()
  erb(:result)
end
get('/timetable/:id/edit') do
  @timetable = Timetable.find(params.fetch('id').to_i)
  erb(:timetable_info)
end
delete('/timetable/:id') do
  @timetable = Timetable.find(params.fetch('id').to_i)
  @timetable.delete()
  redirect to('/')
end
delete('/timetables/delete') do
  Timetable.clear()
  redirect to('/')
end
patch('/timetables/update_name/:id') do
  @timetable = Timetable.find(params.fetch('id').to_i)
  name = params.fetch('name')
  @timetable.update_name(name)
  erb(:timetable_info)
end
