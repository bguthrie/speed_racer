require File.dirname(__FILE__) + '/spec_helper.rb'

describe SpeedRacer do
  
  it "should yield a Comparison object" do
    mock_comparison = mock("comparison", :to_s => "", :ensure_equivalent_results => "")
    SpeedRacer::Comparison.expects(:new).returns mock_comparison
    SpeedRacer.go do
      self.should == mock_comparison
    end
  end
  
  it "should print out the results of the comparison" do
    mock_comparison = mock("comparison", :to_s => "", :ensure_equivalent_results => true)
    SpeedRacer::Comparison.expects(:new).returns mock_comparison
    SpeedRacer.go {}
  end
  
end
