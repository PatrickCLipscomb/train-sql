class Train
  attr_reader(:id, :name)
  define_method(:initialize) do |attributes|
    @id = attributes[:id] || nil
    @name = attributes.fetch(:name)
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end
  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      trains.push(Train.new({
        :id => train.fetch('id').to_i,
        :name => train.fetch('name')
        }))
    end
    trains
  end
  define_method(:==) do |another_train|
    self.id == another_train.id && self.name == another_train.name
  end
  define_singleton_method(:find) do |id|
    returned_trains = Train.all()
    sought_train = nil
    returned_trains.each() do |train|
      if train.id == id
        sought_train = train
      end
    end
    sought_train
  end
  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{self.id};")
  end
  define_method(:update_name) do |name|
    @name = name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id};")
  end
end
