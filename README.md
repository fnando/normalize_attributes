# Normalize Attributes

[![Travis-CI](https://travis-ci.org/fnando/normalize_attributes.png)](https://travis-ci.org/fnando/normalize_attributes)
[![Code Climate](https://codeclimate.com/github/fnando/normalize_attributes/badges/gpa.svg)](https://codeclimate.com/github/fnando/normalize_attributes)
[![Test Coverage](https://codeclimate.com/github/fnando/normalize_attributes/badges/coverage.svg)](https://codeclimate.com/github/fnando/normalize_attributes/coverage)
[![Gem](https://img.shields.io/gem/v/normalize_attributes.svg)](https://rubygems.org/gems/normalize_attributes)
[![Gem](https://img.shields.io/gem/dt/normalize_attributes.svg)](https://rubygems.org/gems/normalize_attributes)

Sometimes you want to normalize data before saving it to the database like down casing e-mails, removing spaces and so on. This Rails plugin allows you to do so in a simple way.

## Usage

To install:

    gem install normalize_attributes

Then on your model:

```ruby
class User < ActiveRecord::Base
  normalize :email, :with => :downcase
end
```

The example above will normalize your `:email` attribute on the `before_save` callback.

You can specify multiple attributes

```ruby
normalize :email, :username, :with => :downcase
```

You can use a block

```ruby
normalize :name do |value|
  value.squish
end
```

You can combine both

```ruby
normalize :name, :with => :downcase do |value|
  value.squish
end
```

The `squish` method is the default normalizer for strings. All you need to is specify the attribute:

```ruby
normalize :content
```

The `compact` method is the default normalizer for arrays (when using `serialize` method):

```ruby
class User < ActiveRecord::Base
  serialize :preferences, Array
  normalize :preferences
end
```

The `normalize` method is aliased as `normalize_attributes`, `normalize_attribute`, `normalize_attr`, and `normalize_attrs`.

You can normalize the attribute before type casting; this is specially useful for normalizing
dates and numbers.

```ruby
class Product
  normalize(:price, :raw => true) {|v| Money.new(v).to_f}
end
```

## Maintainer

* Nando Vieira (http://nandovieira.com)

## License:

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
