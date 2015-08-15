# DirtyNestedAttributes

[![Build Status](https://travis-ci.org/artursbraucs/dirty_nested_attributes.svg)](https://travis-ci.org/artursbraucs/dirty_nested_attributes)
[![Gem Version](https://badge.fury.io/rb/dirty_nested_attributes.svg)](http://badge.fury.io/rb/dirty_nested_attributes)
[![Code Climate](https://codeclimate.com/github/artursbraucs/dirty_nested_attributes/badges/gpa.svg)](https://codeclimate.com/github/artursbraucs/dirty_nested_attributes)
[![Test Coverage](https://codeclimate.com/github/artursbraucs/dirty_nested_attributes/badges/coverage.svg)](https://codeclimate.com/github/artursbraucs/dirty_nested_attributes/coverage)


Tracks nested association changes in ActiveRecord objects.
Marks all changes in parent if something in child (one to one, one to many) records has changed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dirty_nested_attributes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dirty_nested_attributes

## Usage

Include `DirtyNestedAttributes` in your active record class

```ruby
class Post < ActiveRecord::Base
  include DirtyNestedAttributes

  has_many :comments
  accepts_nested_attributes_for :comments
end

post = Post.find_by(title: 'Foo')
post.attributes = { comments_attributes: [{ body: "foo barr" }] }
post.changed? # => true
post.changes # => {'comments' => [{'body' => [nil, 'foo barr'] }]}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/artursbraucs/dirty_nested_attributes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
