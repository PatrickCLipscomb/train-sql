require('rspec')
require('train')
require('stop')
require('stop_train')
require('timetable')
require('pg')
require('pry')

DB = PG.connect({:dbname => "train_sql_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM stops *;")
    DB.exec("DELETE FROM timetables *;")
    DB.exec("DELETE FROM stop_trains *;")
  end
end
