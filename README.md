# Kuebiko
Kuebiko generates URLs from ruby code.

![Kuebiko](https://github.com/tsukasaoishi/kuebiko/wiki/images/kuebiko.jpg)

## Usage
URLs generator class inherits Kuebiko::Base.
```ruby
class ArticleUrl < Kuebiko::Base
  resource :article
  schema :http
  host "kaeruspoon.net"

  def show
    build "articles", article.title
  end
end
```

You can generate path or URL.
```ruby
article.title #=> "first_day"

ArticleUrl.show_path(article) #=> "/articles/first_day"
ArticleUrl.show_url(article) #=> "http://kaeruspoon.net/articles/first_day"

url = ArticleUrl.new(article)
url.show_path #=> "/articles/first_day"
url.show_url #=> "http://kaeruspoon.net/articles/first_day"
```
Methods of suffix ```_path``` generate only path. 
Methods of suffix ```_url``` generate URL.

```show``` instance method is called from ```show_path``` method (or ```show_url```).

### Resources that make up URL
You can specify name of resource. The resource name will use as internal accessor name.
```ruby
class ArticleUrl < Kuebiko::Base
  resource :article
  
  def hoge
    build article.title # article is the internal accessor
  end
end
```

You can pass the resource object to the initializer or generator class methods.
```ruby
url = Article.new(article)
Article.show_path(article)
```
The internal accessor returns nil if you do not pass the resource object.

You can specify more than one resources.
```ruby
class ArticleUrl < Kuebiko::Base
  resource :article, :user
end
```
The order in which you specify the resources will be the order of the objects to pass to the arguments.
```ruby
url = ArticleUrl.new(article, user)
```

The name ```options``` is reserved as internal accessor.

### Components of URL
You can specify default components.
```ruby
Kuebiko.default_components(
  schema: :https,
  host: "kaeruspoon.net", 
  port: 443
)
```
The default value of each components are following when you do not specify value.
* schema ```:http```
* host ```nil```
* port ```80```

You can specify several options.
```ruby
Kuebiko.default_components(
  host: "kaeruspoon.net",
  trailing_slash: true
)
```
Generating the URL with trailing slash if ```trailing_slash``` is true.

You can specify these components and options in Kuebiko::Base class.
```ruby
class ArticleUrl < Kuebiko::Base
  schema :http
  host "hoge.com"
  port 3000
  trailing_slash true
```
The value in Kuebiko::Base class overrides the value of Kuebiko.default_components.

You can specify these components and options at the build method.
```ruby
class ArticleUrl < Kuebiko::Base
  def show
    build "articles", article.title, schema: :https, host: "fuga.com", port: 1234, trailing_slash: true
  end
end
```
The value of build method overrides the value of Kuebiko::Base class.

### Make up the URL
The ```build``` method plays the central role to make up URLs.
The first part of arguments would become the path of URL. The each arguments would be joined by slash.
```ruby
class ArticleUrl < Kuebiko::Base
  def show
    build "articles", article.title
  end
end
```
```"articles"``` and ```article.title``` would be joined by slash. The result is "articles/first_day" (article.title is "first_day").
The ```show_path``` method returns "/articles/first_day".

The second part of argument is components and options (see avobe).
There are following options in addition to ```trailing_slash```.

```query``` is used to make up the query string.
```ruby
build "articles", article.title, query: {special_code: 123}
 #=> "articles/first_day?special_code=123"
```

```anchor``` is used to add the anchor to the URL.
```ruby
build "articles", article.title, anchor: "top_navi"
  #=> "articles/first_day#top_navi"
```

### options internal accessor
There is ```options``` internal accessor.
```ruby
class ArticleUrl < Kuebiko::Base
  resource :article
  
  def show
    queries = options.select {|k,v| %i|code mode|.include?(k.to_sym) }
    build "articles", article.title, query: queries
  end
end

params = {controller: :articles, action: :index, code: "A", hoge: "B"}
url = Article.new(article, params)
url.show_path #=> "/articles/first_day?code=A"
Article.show_path(article, params) #=> "/articles/first_day?code=A"
```
The arguments after resources arguments become ```options```.

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

