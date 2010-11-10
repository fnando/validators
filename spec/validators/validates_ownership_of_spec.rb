require "spec_helper"

describe ".validates_ownership_of" do
  let!(:user) { User.create! }
  let!(:another_user) { User.create! }
  let!(:category) { Category.create!(:user => user) }
  let!(:another_category) { Category.create!(:user => another_user) }
  subject { Task.new(:user => user, :category => category) }

  before do
    Task.validates_ownership_of :category, :with => :user
  end

  it "should be valid when record is owned by the correct user" do
    subject.should be_valid
  end

  it "should not be valid when record is owned by a different user" do
    subject.category = another_category
    subject.should_not be_valid
  end

  it "should raise error without :with option" do
    expect {
      Task.validates_ownership_of :category
    }.to raise_error(ArgumentError)
  end

  it "should raise error when :with options is not a valid type" do
    expect {
      Task.validates_ownership_of :category, :with => user
    }.to raise_error(ArgumentError)
  end

  it "should not be valid when owner is not present" do
    expect {
      subject.user = nil
      subject.should_not be_valid
    }.to_not raise_error
  end

  it "should not be valid when attribute owner is not present" do
    expect {
      subject.category.user = nil
      subject.should_not be_valid
    }.to_not raise_error
  end

  it "should be valid when both owners are nil" do
    expect {
      subject.category.user = nil
      subject.user = nil
      subject.should be_valid
    }.to_not raise_error
  end

  it "should be valid when attribute is nil" do
    expect {
      subject.category = nil
      subject.should be_valid
    }.to_not raise_error
  end

  it "should set error message" do
    subject.user = nil
    subject.should_not be_valid
    subject.errors[:category].should == ["is not associated with your user"]
  end
end
