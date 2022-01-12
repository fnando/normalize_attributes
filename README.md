# Normalize Attributes

[![Tests](https://github.com/fnando/normalize_attributes/workflows/ruby-tests/badge.svg)](https://github.com/fnando/normalize_attributes)
[![Code Climate](https://codeclimate.com/github/fnando/normalize_attributes/badges/gpa.svg)](https://codeclimate.com/github/fnando/normalize_attributes)
[![Gem](https://img.shields.io/gem/v/normalize_attributes.svg)](https://rubygems.org/gems/normalize_attributes)
[![Gem](https://img.shields.io/gem/dt/normalize_attributes.svg)](https://rubygems.org/gems/normalize_attributes)

Sometimes you want to normalize data before saving it to the database like
downcasing e-mails, removing spaces and so on. This Rails plugin allows you to
do so in a simple way.

## Usage

To install:

    gem install normalize_attributes

Then on your model:

```ruby
class User < ActiveRecord::Base
  normalize :email, with: :downcase
end
```

The example above will normalize your `:email` attribute on the `before_save`
callback.

You can specify multiple attributes

```ruby
normalize :email, :username, with: :downcase
```

You can use a block

```ruby
normalize :name do |value|
  value.squish
end
```

You can combine both

```ruby
normalize :name, with: :downcase do |value|
  value.squish
end
```

The `squish` method is the default normalizer for strings. All you need to is
specify the attribute:

```ruby
normalize :content
```

The `compact` method is the default normalizer for arrays (when using
`serialize` method):

```ruby
class User < ActiveRecord::Base
  serialize :preferences, Array
  normalize :preferences
end
```

The `normalize` method is aliased as `normalize_attributes`,
`normalize_attribute`, `normalize_attr`, and `normalize_attrs`.

You can normalize the attribute before type casting; this is specially useful
for normalizing dates and numbers.

```ruby
class Product
  normalize(:price, raw: true) {|v| Money.new(v).to_f }
end
```

You can also use it with `ActiveModel::Model` classes.

```ruby
class UserForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations::Callbacks
  include NormalizeAttributes::Callbacks

  attribute :username
  normalize :username
end
```

## Maintainer

- [Nando Vieira](https://github.com/fnando)

## Contributors

- https://github.com/fnando/normalize_attributes/contributors

## Contributing

For more details about how to contribute, please read
https://github.com/fnando/normalize_attributes/blob/main/CONTRIBUTING.md.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT). A copy of the license can be
found at https://github.com/fnando/normalize_attributes/blob/main/LICENSE.md.

## Code of Conduct

Everyone interacting in the normalize_attributes project's codebases, issue
trackers, chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/fnando/normalize_attributes/blob/main/CODE_OF_CONDUCT.md).
