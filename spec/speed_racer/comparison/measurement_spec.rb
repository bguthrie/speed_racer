require File.dirname(__FILE__) + '/../../spec_helper.rb'

module SpeedRacer
  describe Comparison::Measurement do
    it "has a name" do
      Comparison::Measurement.new("foo", 5).name.should == "foo"
    end
    
    it "has a number of times it should be averaged over" do
      Comparison::Measurement.new("foo", 5).times.should == 5
    end
    
    it "should have a measured time of 0.0 if no block is given" do
      Comparison::Measurement.new("foo", 5).measured_time.should == 0.0
    end
    
    it "should measure the time of the given block" do
      Comparison::Measurement.new("foo", 5) { 10 ** 100 }.measured_time.should > 0.0
    end
    
    it "should be measurable against another measurement" do
      slower_measurement = Comparison::Measurement.new("foo", 5) { 10 ** 1000 }
      faster_measurement = Comparison::Measurement.new("foo", 5) { 10 ** 100 }
      faster_measurement.differential(slower_measurement).should > 1.0
      slower_measurement.differential(faster_measurement).should < 1.0
      slower_measurement.differential(slower_measurement).should == 1.0
    end
    
    it "should pass the given data into the measured block" do
      Comparison::Measurement.new("foo", 5, "an argument") { |n| n }.result.should == "an argument"
    end
    
    it "should pass multiple pieces of data into the given block as multiple arguments" do
      Comparison::Measurement.new("foo", 5, "an argument", "another argument") do |one, two|
        "#{one} and #{two}"
      end.result.should == "an argument and another argument"
    end
    
    it "should duplicate the given data when it calls the measured block" do
      given_data = "some data"
      Comparison::Measurement.new("foo", 5, given_data) do |measured_data|
        measured_data.should_not equal(given_data)
      end
    end
  end
end