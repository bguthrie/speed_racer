require File.dirname(__FILE__) + '/../spec_helper.rb'

module SpeedRacer
  describe Comparison do
  
    before(:each) { @comparison = Comparison.new(1) }
    attr_reader :comparison
  
    it "records the requested number of times to run the test" do
      Comparison.new(5).times.should == 5
    end
    
    it "starts with an empty list of measurements" do
      Comparison.new(1).measurements.should be_empty
    end
    
    it "allows you to set the data to be passed in to the block" do
      comparison.data "foo", "bar"
      comparison.data.should == ["foo", "bar"]
    end
    
    it "yields a default empty list of data" do
      comparison.data.should be_empty
    end
    
    it "measures and sets a baseline" do
      comparison.against("baseline") {}.name.should == "baseline"
    end
    
    it "adds a measurement to the list of measurements" do
      comparison.measure("measurement") {}
      comparison.measurements.any? {|m| m.name == "measurement"}.should be_true
    end
    
    it "doesn't include the baseline in the list of measurements" do
      comparison.against("baseline") {}
      comparison.measure("measurement") {}
      comparison.measurements.map {|m| m.name}.should_not include("baseline")
    end
    
    module Foo
      def bar; end
    end
    
    it "allows you to include a module in an instance of itself" do
      comparison.send(:include, Foo)
      comparison.should respond_to(:bar)
      Comparison.instance_methods.should_not include("foo")
    end
  end
end