require "spec_helper"

describe ".validates_datetime" do
  subject { User.new }

  context "default options" do
    before do
      User.validates_datetime :registered_at
      User.validates :birthday, :datetime => true
    end

    VALID_DATES.each do |date|
      it "accepts #{date.inspect} as valid date" do
        subject.registered_at = date
        subject.birthday = date

        subject.should be_valid
      end
    end

    INVALID_DATES.each do |date|
      it "rejects #{date.inspect} as valid date" do
        subject.registered_at = date
        subject.birthday = date
        subject.should_not be_valid

        subject.errors[:registered_at].should_not be_empty
        subject.errors[:birthday].should_not be_empty
      end
    end

    it "includes default error message" do
      subject.registered_at = nil
      subject.should_not be_valid

      subject.errors[:registered_at].should == ["is not a valid date"]
    end
  end

  context "after option" do
    it "rejects when date is set to before :after option" do
      User.validates_datetime :registered_at, :after => 1.week.from_now
      subject.registered_at = Time.now

      subject.should_not be_valid
      subject.errors[:registered_at].should == ["needs to be after #{I18n.l(1.week.from_now)}"]
    end

    it "accepts when date is set accordingly to the :after option" do
      User.validates_datetime :registered_at, :after => 1.week.from_now
      subject.registered_at = 2.weeks.from_now

      subject.should be_valid
    end

    it "validates using today as date" do
      User.validates_datetime :registered_at, :after => :today

      subject.registered_at = Time.now
      subject.should_not be_valid

      subject.registered_at = Date.today
      subject.should_not be_valid

      subject.registered_at = Date.tomorrow
      subject.should be_valid

      subject.registered_at = 1.day.from_now
      subject.should be_valid
    end

    it "validates using now as date" do
      User.validates_datetime :registered_at, :after => :now

      subject.registered_at = Time.now
      subject.should_not be_valid

      subject.registered_at = Date.today
      subject.should_not be_valid

      subject.registered_at = Date.tomorrow
      subject.should be_valid

      subject.registered_at = 1.day.from_now
      subject.should be_valid
    end

    it "validates using method as date" do
      User.validates_datetime :starts_at
      User.validates_datetime :ends_at, :after => :starts_at, :if => :starts_at?

      subject.starts_at = nil
      subject.ends_at = Time.now
      subject.should_not be_valid
      subject.errors[:ends_at].should be_empty

      subject.starts_at = Time.parse("Apr 26 2010")
      subject.ends_at = Time.parse("Apr 25 2010")
      subject.should_not be_valid
      subject.errors[:ends_at].should == ["needs to be after #{I18n.l(Time.parse("Apr 26 2010"))}"]

      subject.starts_at = Time.now
      subject.ends_at = 1.hour.from_now
      subject.should be_valid
    end
  end

  context "before option" do
    it "rejects when date is set to after :before option" do
      User.validates_datetime :registered_at, :before => 1.week.ago
      subject.registered_at = Time.now

      subject.should_not be_valid
      subject.errors[:registered_at].should == ["needs to be before #{I18n.l(1.week.ago)}"]
    end

    it "accepts when date is set accordingly to the :before option" do
      User.validates_datetime :registered_at, :before => 1.week.ago
      subject.registered_at = 2.weeks.ago

      subject.should be_valid
    end
  end
end
