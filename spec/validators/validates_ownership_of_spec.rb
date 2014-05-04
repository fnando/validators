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

  it "is valid when record is owned by the correct user" do
    expect(subject).to be_valid
  end

  it "is invalid when record is owned by a different user" do
    subject.category = another_category
    expect(subject).not_to be_valid
  end

  it "raises error without :with option" do
    expect {
      Task.validates_ownership_of :category
    }.to raise_error(ArgumentError)
  end

  it "raises error when :with options is not a valid type" do
    expect {
      Task.validates_ownership_of :category, :with => user
    }.to raise_error(ArgumentError)
  end

  it "is invalid when owner is not present" do
    expect {
      subject.user = nil
      expect(subject).not_to be_valid
    }.to_not raise_error
  end

  it "is invalid when attribute owner is not present" do
    expect {
      subject.category.user = nil
      expect(subject).not_to be_valid
    }.to_not raise_error
  end

  it "is valid when both owners are nil" do
    expect {
      subject.category.user = nil
      subject.user = nil
      expect(subject).to be_valid
    }.to_not raise_error
  end

  it "is valid when attribute is nil" do
    expect {
      subject.category = nil
      expect(subject).to be_valid
    }.to_not raise_error
  end

  it "sets error message" do
    subject.user = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:category]).to eq(["is not associated with your user"])
  end
end
