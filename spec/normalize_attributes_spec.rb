require "spec_helper"

describe "Normalize Attributes" do
  before do
    User.normalize_options = {}
  end

  it "should respond to aliases" do
    User.should respond_to(:normalize)
    User.should respond_to(:normalize_attr)
    User.should respond_to(:normalize_attrs)
    User.should respond_to(:normalize_attribute)
    User.should respond_to(:normalize_attributes)
  end

  it "should apply single normalization method" do
    User.normalize :email, :with => :downcase
    user = User.create(:email => "JOHN@DOE.COM")

    user.email.should == "john@doe.com"
  end

  it "should apply multiple normalization methods" do
    User.normalize :email, :with => [:downcase, :reverse]
    user = User.create(:email => "JOHN@DOE.COM")

    user.email.should == "moc.eod@nhoj"
  end

  it "should apply proc" do
    User.normalize(:email) {|v| v.downcase }
    user = User.create(:email => "JOHN@DOE.COM")

    user.email.should == "john@doe.com"
  end

  it "should apply instance method" do
    User.normalize(:username, :with => :normalize_username)
    user = User.create(:username => "JOHNDOE")

    user.username.should == "johndoe"
  end

  it "should use value before type casting" do
    User.normalize(:age, :raw => true) do |v|
      v.should == "1.2"
      v.to_f * 10
    end

    user = User.create(:age => "1.2")
    user.age.should == 12
  end

  it "should apply normalizers to accessor" do
    # User.normalize()
  end

  it "should combine both method names and procs as normalization methods" do
    User.normalize(:email, :with => :downcase) {|v| v.reverse }
    user = User.create(:email => "JOHN@DOE.COM")

    user.email.should == "moc.eod@nhoj"
  end

  it "should normalize multiple attributes" do
    User.normalize :email, :username, :with => :downcase
    user = User.create(:email => "JOHN@DOE.COM", :username => "JOHN")

    user.email.should == "john@doe.com"
    user.username.should == "john"
  end

  it "should not apply on associations" do
    User.normalize :email, :with => :downcase
    user = User.create(:email => "JOHN@DOE.COM", :username => "JOHN")

    expect {
      user.tokens.create!
    }.to_not raise_error
  end

  it "should apply default filter on strings" do
    User.normalize :email
    user = User.create(:email => "    \n\t    john@doe.com    \t\t\n\r\n", :username => "john")

    user.email.should == "john@doe.com"
  end

  it "should apply default filter on arrays" do
    User.normalize :preferences
    user = User.create(:preferences => [nil, :games, :music])
    user.preferences.should == [:games, :music]
  end

  it "should not apply default filter on unknown objects" do
    User.normalize :username

    expect {
      user = User.create(:username => 100)
      user.username.should == 100
    }.to_not raise_error
  end

  it "should not apply filter when object do not respond to normalizer" do
    User.normalize :username, :with => :missing

    expect {
      user = User.create(:username => nil)
      user.save
    }.to_not raise_error
  end
end
