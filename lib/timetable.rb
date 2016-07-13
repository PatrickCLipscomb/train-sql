class Timetable
  attr_reader(:id, :name)
  define_method(:initialize) do |attributes|
    @id = attributes[:id] || nil
    @name = attributes.fetch(:name)
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO timetables (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end
  define_singleton_method(:all) do
    returned_timetables = DB.exec("SELECT * FROM timetables;")
    timetables = []
    returned_timetables.each() do |timetable|
      timetables.push(Timetable.new({
        :id => timetable.fetch('id').to_i,
        :name => timetable.fetch('name')
        }))
    end
    timetables
  end
  define_method(:==) do |another_timetable|
    self.id == another_timetable.id && self.name == another_timetable.name
  end
  define_singleton_method(:find) do |id|
    returned_timetables = Timetable.all()
    sought_timetable = nil
    returned_timetables.each() do |timetable|
      if timetable.id == id
        sought_timetable = timetable
      end
    end
    sought_timetable
  end
  define_method(:delete) do
    DB.exec("DELETE FROM timetables WHERE id = #{self.id};")
  end
  define_method(:update_name) do |name|
    @name = name
    DB.exec("UPDATE timetables SET name = '#{@name}' WHERE id = #{self.id};")
  end
  define_singleton_method(:clear) do
    DB.exec("DELETE FROM timetables")
  end
end
