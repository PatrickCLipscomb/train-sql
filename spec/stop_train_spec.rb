require('spec_helper')

describe(Stoptrain) do
  describe('#save') do
    it "adds the selected stop_train to the database" do
      stop_train = Stoptrain.new({:train_id => 1, :stop_id => 1})
      stop_train.save()
      expect(Stoptrain.all()).to(eq([stop_train]))
    end
  end
end
