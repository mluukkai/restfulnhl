require "rspec"
require "../formatter"

describe GoalFormatter do
  before(:each) do
    @formatter = Formatter.goal
  end

  it "should bold goals" do
    @formatter.goals("1").should == "<b>1</b>"
  end

  it "should not modify assists" do
    @formatter.assists("1").should == "1"
  end

  it "should not modify points" do
    @formatter.points("1").should == "1"
  end
end

describe AssistFormatter do
  before(:each) do
    @formatter = Formatter.assist
  end

  it "should bold assists" do
    @formatter.assists("1").should == "<b>1</b>"
  end

  it "should not modify points" do
    @formatter.points("1").should == "1"
  end

  it "should not modify goals" do
    @formatter.goals("1").should == "1"
  end
end

describe PointFormatter do
  before(:each) do
    @formatter = Formatter.point
  end

  it "should bold points" do
    @formatter.points("1").should == "<b>1</b>"
  end

  it "should not modify goals" do
    @formatter.goals("1").should == "1"
  end

  it "should not modify assists" do
    @formatter.assists("1").should == "1"
  end
end