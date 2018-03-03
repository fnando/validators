# Validators

[![Build Status](https://travis-ci.org/fnando/validators.svg)](https://travis-ci.org/fnando/validators)
[![Code Climate](https://codeclimate.com/github/fnando/validators/badges/gpa.svg)](https://codeclimate.com/github/fnando/validators)
[![Test Coverage](https://codeclimate.com/github/fnando/validators/badges/coverage.svg)](https://codeclimate.com/github/fnando/validators)

Add some nice ActiveModel/ActiveRecord validators.

## Installation

```
gem install validators
```

Then add it to your Gemfile:

```ruby
gem "validators"
```

## Usage

### validates_email_format_of

```ruby
class User < ActiveRecord::Base
  # old fashion
  validates_email_format_of :email

  # alternative way
  validates :email, email: true
end
```

By default, it rejects disposable e-mails (e.g. mailinator). This loads ~15kb, but you can disable this validation by setting `disposable: true`.

```ruby
class User < ActiveRecord::Base
  validates_email_format_of :email, disposable: true
end
```

You can also validate the tld.

```ruby
class User < ActiveRecord::Base
  validates_email_format_of :email, tld: true
end
```

### validates_url_format_of

```ruby
class User < ActiveRecord::Base
  validates_url_format_of :site

  # validates TLD against list of valid TLD.
  # Loads ~5kb of text.
  validates_url_format_of :site, tld: true
end
```

### validates_ownership_of

```ruby
class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_ownership_of :category, :with => :user
end

user = User.find(1)
another_user = User.find(2)

user_category = user.categories.first
another_user_category = another_user.categories.first

task = user.tasks.create(:category => user_category)
task.valid?
#=> true

task = user.tasks.create(:category => another_user_category)
task.valid?
#=> false
```

### validates_ip_address

```ruby
class Server < ActiveRecord::Base
  validates_ip_address :address
  validates_ip_address :address, :only => :v4
  validates_ip_address :address, :only => :v6
end
```

### validates_datetime

```ruby
class Server < ActiveRecord::Base
  validates_datetime :starts_at
  validates_datetime :ends_at, :after => :starts_at, :if => :starts_at?
  validates_datetime :ends_at, :after => :now
  validates_datetime :ends_at, :before => :today

  validates :starts_at, :datetime => true
end
```

### validates_cpf_format_of

```ruby
class User < ActiveRecord::Base
  validates_cpf_format_of :document
end
```

### validates_cnpj_format_of

```ruby
class User < ActiveRecord::Base
  validates_cnpj_format_of :document
end
```

### validates_hostname

Rules:

- maximum length of hostname is 255 characters
- maximum length of each hostname label is 63 characters
- characters allowed in hostname labels are a-z, A-Z, 0-9 and hyphen
- labels do not begin or end with a hyphen
- labels do not consist of numeric values only
- TLD validation (optional)


```ruby
class Server < ActiveRecord::Base
  validates_hostname :hostname
  validates_hostname :hostname, tld: true
end
```

## Maintainer

* [Nando Vieira](http://simplesideias.com.br)

## License

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
