class Stop
  attr_reader(:id, :name)
  define_method(:initialize) do |attributes|
    @id = attributes[:id] || nil
    @name = attributes.fetch(:name)
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO stops (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end
  define_singleton_method(:all) do
    returned_stops = DB.exec("SELECT * FROM stops;")
    stops = []
    returned_stops.each() do |stop|
      stops.push(Stop.new({
        :id => stop.fetch('id').to_i,
        :name => stop.fetch('name')
        }))
    end
    stops
  end
  define_method(:==) do |another_stop|
    self.id == another_stop.id && self.name == another_stop.name
  end
  define_singleton_method(:find) do |id|
    returned_stops = Stop.all()
    sought_stop = nil
    returned_stops.each() do |stop|
      if stop.id == id
        sought_stop = stop
      end
    end
    sought_stop
  end
  define_method(:delete) do
    DB.exec("DELETE FROM stops WHERE id = #{self.id};")
  end
  define_method(:update_name) do |name|
    @name = name
    DB.exec("UPDATE stops SET name = '#{@name}' WHERE id = #{self.id};")
  end
end