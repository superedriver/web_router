[![Build Status](https://travis-ci.org/superedriver/web_router.svg?branch=master)](https://travis-ci.org/superedriver/web_router)


# WebRouter

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/web_router`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'web_router'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install web_router

## Usage

1. Write controllers with methods. WebRouter controllers responds to json, text

```ruby
class TestsController < WebRouter::Controller
  def show
    response(:json, params)
  end

  def test
    response(:text, "Required method #{request.request_method}")
  end
end
```

2. Create new application and configure it with block of routes
Available HTTP methods: get, post, put, delete
You can configure routs using controller`s methods or Rack Applications

```ruby
WebRouter::Router.new.configure do
  get '/test', ->(env) { [200, {}, ['get test']] }
  post '/test', ->(env) { [200, {}, ['post test']] }
  get '/comments/:name/:other_one', 'tests#show'
  get '/testing', 'tests#test'
end

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/web_router. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

