# Kuebiko

Kuebiko generates URLs from ruby code.

![Kuebiko](https://github.com/tsukasaoishi/kuebiko/wiki/images/kuebiko.jpg)

## Usage

URLs generator class inherited Kuebiko::Base.
```ruby
class ArticleUrl < Kuebiko::Base
  schema :http
  host "kaeruspoon.net"

  def show(article)
    ["articles", article.title]
  end
end
```

generate URL.
```ruby
article.title #=> "first_day"

ArticleUrl.show_path(article) #=> "/articles/first_day"
ArticleUrl.show_url(article) #=> "http://kaeruspoon.net/articles/first_day"
```
Class methods of suffix ```_path``` generate url only path. Suffix ```_url``` generate full url.

```show``` instance method is called from ```show_path``` class method (or ```show_url```).
The instance method must return Array or String object.

### query parameters

generate URL with query parameters.
```ruby
ArticleUrl.show_path(article, query: {special_code: '123'})
  #=> "/articles/first_day?special_code=123
```

### anchor
generate URL with anchor.
```ruby
ArticleUrl.show_path(article, anchor: "navi")
  #=> "/articles/first_day#navi"
```

### schema
specify schema and generate URL.
```ruby
ArticleUrl.show_url(article, schema: "https")
  #=> "https://kaeruspoon.net/articles/first_day"
```

```schema``` DSL is specify default schema.
```ruby
class ArticleUrl < Kuebiko::Base
  schema :hoge
  ...
end

ArticleUrl.show_url(article) #=> "hoge://kaeruspoon.net/articles/first_day"
```

### host
specify host and generate URL.
```ruby
ArticleUrl.show_url(article, host: "hoge.com")
  #=> "http://hoge.com/articles/first_day"
```

```host``` DSL is specify default host.
```ruby
class ArticleUrl < Kuebiko::Base
  host "fuga.com"
  ...
end

ArticleUrl.show_url(article) #=> "http://fuga.com/articles/first_day"
```

### port
generate URL with port.
```ruby
ArticleUrl.show_url(article, port: 3000)
  #=> "http://kaeruspoon.net:3000/articles/first_day"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kuebiko'
```

And then execute:
```
$ bundle
```

Or install it yourself as:
```
$ gem install kuebiko
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tsukasaoishi/kuebiko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

