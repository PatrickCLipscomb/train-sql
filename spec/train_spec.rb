require('spec_helper')

describe(Train) do
  describe('.all') do
    it "returns all of the trains saved in the database" do
      train1 = Train.new({:name => 'Chuck'})
      train2 = Train.new({:name => 'Wallace'})
      train1.save()
      train2.save()
      expect(Train.all()).to(eq([train1, train2]))
    end
  end
  describe('#save') do
    it "takes a train object and saves it to the database" do
      train1 = Train.new({:name => 'Thomas'})
      train1.save()
      expect(Train.all()).to(eq([train1]))
    end
  end
  describe('#==') do
    it "tests to see if two separate objects have the same properties" do
      train1 = Train.new({:name => 'Chuck'})
      train2 = Train.new({:name => 'Chuck'})
      expect(train1).to(eq(train2))
    end
  end
  describe('.find') do
    it "will return a train by id" do
      train1 = Train.new({:name => 'Chuck'})
      train2 = Train.new({:name => 'Wallace'})
      train1.save()
      train2.save()
      expect(Train.find(train1.id)).to(eq(train1))
    end
  end
  describe('#delete') do
    it "will return a train by id" do
      train1 = Train.new({:name => 'Chuck'})
      train2 = Train.new({:name => 'Wallace'})
      train1.save()
      train2.save()
      train2.delete()
      expect(Train.all()).to(eq([train1]))
    end
  end
  describe('#update_name') do
    it "will update the name property of a given train" do
      train1 = Train.new({:name => 'Chuck'})
      train1.save()
      train1.update_name('Synthia')
      expect(train1.name).to(eq('Synthia'))
    end
  end
end
