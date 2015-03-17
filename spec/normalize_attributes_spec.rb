require "spec_helper"

describe "Normalize Attributes" do
  before do
    User.normalize_options = {}
  end

  it "should respond to aliases" do
    expect(User).to respond_to(:normalize)
    expect(User).to respond_to(:normalize_attr)
    expect(User).to respond_to(:normalize_attrs)
    expect(User).to respond_to(:normalize_attribute)
    expect(User).to respond_to(:normalize_attributes)
  end

  it "should apply single normalization method" do
    User.normalize :email, :with => :downcase
    user = User.create(:email => "JOHN@DOE.COM")

    expect(user.email).to eq("john@doe.com")
  end

  it "should apply multiple normalization methods" do
    User.normalize :email, :with => [:downcase, :reverse]
    user = User.create(:email => "JOHN@DOE.COM")

    expect(user.email).to eq("moc.eod@nhoj")
  end

  it "should apply proc" do
    User.normalize(:email) {|v| v.downcase }
    user = User.create(:email => "JOHN@DOE.COM")

    expect(user.email).to eq("john@doe.com")
  end

  it "should apply instance method" do
    User.normalize(:username, :with => :normalize_username)
    user = User.create(:username => "JOHNDOE")

    expect(user.username).to eq("johndoe")
  end

  it "should use value before type casting" do
    User.normalize(:age, :raw => true) do |v|
      expect(v).to eq("1.2")
      v.to_f * 10
    end

    user = User.create(:age => "1.2")
    expect(user.age).to eq(12)
  end

  it "should apply normalizers to accessor" do
    # User.normalize()
  end

  it "should combine both method names and procs as normalization methods" do
    User.normalize(:email, :with => :downcase) {|v| v.reverse }
    user = User.create(:email => "JOHN@DOE.COM")

    expect(user.email).to eq("moc.eod@nhoj")
  end

  it "should normalize multiple attributes" do
    User.normalize :email, :username, :with => :downcase
    user = User.create(:email => "JOHN@DOE.COM", :username => "JOHN")

    expect(user.email).to eq("john@doe.com")
    expect(user.username).to eq("john")
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

    expect(user.email).to eq("john@doe.com")
  end

  it "should apply default filter on arrays" do
    User.normalize :preferences
    user = User.create(:preferences => [nil, :games, :music])
    expect(user.preferences).to eq([:games, :music])
  end

  it "should not apply default filter on unknown objects" do
    User.normalize :username

    expect {
      user = User.create(:username => 100)
      expect(user.username).to eq("100")
    }.not_to raise_error
  end

  it "should not apply filter when object do not respond to normalizer" do
    User.normalize :username, :with => :missing

    expect {
      user = User.create(:username => nil)
      user.save
    }.to_not raise_error
  end
end
