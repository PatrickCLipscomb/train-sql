require('spec_helper')

describe(Stoptrain) do
  describe('#save') do
    it "adds the selected stop_train to the database" do
      stop_train = Stoptrain.new({:train_id => 1, :stop_id => 1})
      stop_train.save()
      expect(Stoptrain.all()).to(eq([stop_train]))
    end
  end
  describe('.assign_stops_to_trains') do
    it "creates a association between one train and multiple stops" do
      Stoptrain.assign_stops_to_trains(2, [2,3,4])
      expect(Stoptrain.assignment_check()).to(eq(3))
    end
  end
end
