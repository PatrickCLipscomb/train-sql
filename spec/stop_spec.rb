require('spec_helper')

describe(Stop) do
  describe('.all') do
    it "returns all of the stops saved in the database" do
      stop1 = Stop.new({:name => 'Chuck'})
      stop2 = Stop.new({:name => 'Wallace'})
      stop1.save()
      stop2.save()
      expect(Stop.all()).to(eq([stop1, stop2]))
    end
  end
  describe('#save') do
    it "takes a stop object and saves it to the database" do
      stop1 = Stop.new({:name => 'Thomas'})
      stop1.save()
      expect(Stop.all()).to(eq([stop1]))
    end
  end
  describe('#==') do
    it "tests to see if two separate objects have the same properties" do
      stop1 = Stop.new({:name => 'Chuck'})
      stop2 = Stop.new({:name => 'Chuck'})
      expect(stop1).to(eq(stop2))
    end
  end
  describe('.find') do
    it "will return a stop by id" do
      stop1 = Stop.new({:name => 'Chuck'})
      stop2 = Stop.new({:name => 'Wallace'})
      stop1.save()
      stop2.save()
      expect(Stop.find(stop1.id)).to(eq(stop1))
    end
  end
  describe('#delete') do
    it "will return a stop by id" do
      stop1 = Stop.new({:name => 'Chuck'})
      stop2 = Stop.new({:name => 'Wallace'})
      stop1.save()
      stop2.save()
      stop2.delete()
      expect(Stop.all()).to(eq([stop1]))
    end
  end
  describe('#update_name') do
    it "will update the name property of a given stop" do
      stop1 = Stop.new({:name => 'Chuck'})
      stop1.save()
      stop1.update_name('Synthia')
      expect(stop1.name).to(eq('Synthia'))
    end
  end
end
