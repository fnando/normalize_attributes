require File.dirname(__FILE__) + "/spec_helper"

describe "Normalize Attributes" do
  before do
    User.normalize_attributes_options = {}
  end

  it "should apply single normalization method" do
    User.normalize_attribute :email, :with => :downcase
    user = User.create(:email => "JOHN@DOE.COM")

    user.email.should == "john@doe.com"
  end

  it "should apply multiple normalization methods" do
    User.normalize_attribute :email, :with => [:downcase, :reverse]
    user = User.create(:email => "JOHN@DOE.COM")

    user.email.should == "moc.eod@nhoj"
  end

  it "should apply proc" do
    User.normalize_attribute(:email) {|v| v.downcase }
    user = User.create(:email => "JOHN@DOE.COM")

    user.email.should == "john@doe.com"
  end

  it "should combine both method names and procs as normalization methods" do
    User.normalize_attribute(:email, :with => :downcase) {|v| v.reverse }
    user = User.create(:email => "JOHN@DOE.COM")

    user.email.should == "moc.eod@nhoj"
  end

  it "should normalize multiple attributes" do
    User.normalize_attributes :email, :username, :with => :downcase
    user = User.create(:email => "JOHN@DOE.COM", :username => "JOHN")

    user.email.should == "john@doe.com"
    user.username.should == "john"
  end

  it "should not apply on associations" do
    User.normalize_attributes :email, :with => :downcase
    user = User.create(:email => "JOHN@DOE.COM", :username => "JOHN")

    doing {
      user.tokens.create!
    }.should_not raise_error
  end

  it "should apply default filter" do
    User.normalize_attributes :email
    user = User.create(:email => "    \n\t    john@doe.com    \t\t\n\r\n", :username => "john")

    user.email.should == "john@doe.com"
  end

  it "should not apply default filter on non-string objects" do
    User.normalize_attributes :username, :with => proc {|v| v * 2 }
    user = User.create(:username => 100)

    user.username.should == 200
  end
end
