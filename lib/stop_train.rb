class Stoptrain
  attr_reader(:id, :train_id, :stop_id)
  define_method(:initialize) do |attributes|
    @id = attributes[:id] || nil
    @train_id = attributes.fetch(:train_id)
    @stop_id = attributes.fetch(:stop_id)
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO stop_trains (train_id, stop_id) VALUES (#{@train_id}, #{@stop_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i
  end
  define_singleton_method(:all) do
    returned_pairs = DB.exec('SELECT * FROM stop_trains;')
    found_pairs = []
    returned_pairs.each() do |pair|
      found_pairs.push(Stoptrain.new({:id => pair.fetch('id').to_i, :train_id => pair.fetch('train_id').to_i, :stop_id => pair.fetch('stop_id').to_i}))
    end
    found_pairs
  end
  define_method(:==) do |another_pair|
    (self.id == another_pair.id) && (self.train_id == another_pair.train_id) && (self.stop_id == another_pair.stop_id)
  end
  define_singleton_method(:assign_stops_to_trains) do |train_id, stop_ids|
    stop_ids.each() do |stop_id|
      stop_train = Stoptrain.new({
        :stop_id => stop_id,
        :train_id => train_id
        })
      stop_train.save()
    end
  end
  define_singleton_method(:assign_trains_to_stops) do |stop_id, train_ids|
    train_ids.each() do |train_id|
      stop_train = Stoptrain.new({
        :stop_id => stop_id,
        :train_id => train_id
        })
      stop_train.save()
    end
  end
  define_singleton_method(:assignment_check) do
    associations = DB.exec("SELECT * FROM stop_trains;")
    assoc_objects = []
    associations.each() do |association|
      assoc_objects.push(Stoptrain.new({:train_id => association.fetch('train_id'), :stop_id => association.fetch('stop_id')}))
    end
    assoc_objects.length
  end
  define_singleton_method(:clear) do
    DB.exec("DELETE FROM stop_trains")
  end
end
