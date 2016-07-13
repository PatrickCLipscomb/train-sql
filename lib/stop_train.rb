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
end
