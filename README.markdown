Normalize Attributes
====================

Sometimes you want to normalize data before saving it to the database like down casing e-mails, removing spaces and so on.
This Rails plugin allows you to do so in a simple way.

Usage
-----

To install:

	script/plugin install git://github.com/fnando/normalize_attributes.git

Then on your model:

	class User < ActiveRecord::Base
	  normalize_attribute :email, :with => :downcase
	end

The example above will normalize your `:email` attribute on the **before_save** callback.

You can specify multiple attributes

	normalize_attributes :email, :username, :with => :downcase

You can use a Proc

	normalize_attribute :name do |value|
	  value.squish
	end

You can combine both

	normalize_attribute :name, :with => :downcase do |value|
	  value.squish
	end

The `normalize_attributes` method is aliased as `normalize_attribute`, `normalize_attr` and `normalize_attrs`.

To-Do
-----

* Apply regular expressions

Maintainer
----------

* Nando Vieira (<http://simplesideias.com.br>)

License:
--------

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