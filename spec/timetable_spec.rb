require('spec_helper')

describe(Timetable) do
  describe('.all') do
    it "returns all of the timetables saved in the database" do
      timetable1 = Timetable.new({:name => 'Chuck'})
      timetable2 = Timetable.new({:name => 'Wallace'})
      timetable1.save()
      timetable2.save()
      expect(Timetable.all()).to(eq([timetable1, timetable2]))
    end
  end
  describe('#save') do
    it "takes a timetable object and saves it to the database" do
      timetable1 = Timetable.new({:name => 'Thomas'})
      timetable1.save()
      expect(Timetable.all()).to(eq([timetable1]))
    end
  end
  describe('#==') do
    it "tests to see if two separate objects have the same properties" do
      timetable1 = Timetable.new({:name => 'Chuck'})
      timetable2 = Timetable.new({:name => 'Chuck'})
      expect(timetable1).to(eq(timetable2))
    end
  end
  describe('.find') do
    it "will return a timetable by id" do
      timetable1 = Timetable.new({:name => 'Chuck'})
      timetable2 = Timetable.new({:name => 'Wallace'})
      timetable1.save()
      timetable2.save()
      expect(Timetable.find(timetable1.id)).to(eq(timetable1))
    end
  end
  describe('#delete') do
    it "will return a timetable by id" do
      timetable1 = Timetable.new({:name => 'Chuck'})
      timetable2 = Timetable.new({:name => 'Wallace'})
      timetable1.save()
      timetable2.save()
      timetable2.delete()
      expect(Timetable.all()).to(eq([timetable1]))
    end
  end
  describe('#update_name') do
    it "will update the name property of a given timetable" do
      timetable1 = Timetable.new({:name => 'Chuck'})
      timetable1.save()
      timetable1.update_name('Synthia')
      expect(timetable1.name).to(eq('Synthia'))
    end
  end
end
