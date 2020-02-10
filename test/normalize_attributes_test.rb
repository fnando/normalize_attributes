# frozen_string_literal: true

require "test_helper"

class NormalizeAttributesTest < Minitest::Test
  setup do
    User.normalize_options = {}
  end

  test "respond to aliases" do
    assert User.respond_to?(:normalize)
    assert User.respond_to?(:normalize_attr)
    assert User.respond_to?(:normalize_attrs)
    assert User.respond_to?(:normalize_attribute)
    assert User.respond_to?(:normalize_attributes)
  end

  test "apply single normalization method" do
    User.normalize :email, with: :downcase
    user = User.create(email: "JOHN@DOE.COM")

    assert_equal "john@doe.com", user.email
  end

  test "apply multiple normalization methods" do
    User.normalize :email, with: %i[downcase reverse]
    user = User.create(email: "JOHN@DOE.COM")

    assert_equal "moc.eod@nhoj", user.email
  end

  test "apply proc" do
    User.normalize(:email, &:downcase)
    user = User.create(email: "JOHN@DOE.COM")

    assert_equal "john@doe.com", user.email
  end

  test "apply instance method" do
    User.normalize(:username, with: :normalize_username)
    user = User.create(username: "JOHNDOE")

    assert_equal "johndoe", user.username
  end

  test "use value before type casting" do
    User.normalize(:age, raw: true) do |v|
      v.to_f * 10
    end

    user = User.create(age: "1.2")
    assert_equal 12, user.age
  end

  test "combine both method names and procs as normalization methods" do
    User.normalize(:email, with: :downcase, &:reverse)
    user = User.create(email: "JOHN@DOE.COM")

    assert_equal "moc.eod@nhoj", user.email
  end

  test "normalize multiple attributes" do
    User.normalize :email, :username, with: :downcase
    user = User.create(email: "JOHN@DOE.COM", username: "JOHN")

    assert_equal "john@doe.com", user.email
    assert_equal "john", user.username
  end

  test "don't apply on associations" do
    User.normalize :email, with: :downcase
    user = User.create(email: "JOHN@DOE.COM", username: "JOHN")

    user.tokens.create!
  end

  test "apply default filter on strings" do
    User.normalize :email
    user = User.create(
      email: "    \n\t    john@doe.com    \t\t\n\r\n",
      username: "john"
    )

    assert_equal "john@doe.com", user.email
  end

  test "apply default filter on arrays" do
    User.normalize :preferences
    user = User.create(preferences: [nil, :games, :music])

    assert_equal %i[games music], user.preferences
  end

  test "don't apply default filter on unknown objects" do
    User.normalize :username
    user = User.create(username: 100)

    assert_equal "100", user.username
  end

  test "don't apply filter when object do not respond to normalizer" do
    User.normalize :username, with: :missing

    user = User.create(username: nil)
    user.save
  end

  test "normalize attributes that are not backed by database columns" do
    User.normalize :nickname, with: :downcase

    user = User.new(username: "john@doe.com")
    user.nickname = "JOHNNY D"
    user.save

    assert_equal "johnny d", user.nickname
  end

  test "normalize ActiveModel::Model objects" do
    model = Class.new do
      include ActiveModel::Model
      include ActiveModel::Attributes
      include ActiveModel::Validations::Callbacks
      include NormalizeAttributes::Callbacks

      attribute :username
      normalize :username
    end

    instance = model.new(username: "      john      ")
    instance.valid?

    assert_equal "john", instance.username
  end
end
