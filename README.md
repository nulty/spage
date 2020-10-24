# Spage

Spage is a Ruby client for integrating Statuspage.io into your ruby app. The idea is for it to be more than just a set of http requests to the server. It tries to model the data on the server for you so you don't have to.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spage'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install spage


## Official Docs

[StatusPage API documentation](https://developer.statuspage.io/)


## Usage

### Configuration
Configure the client with your API key
You can put this in an initailizer in Rails

```ruby
Spage.configure do |config|
  config.api_key(YOUR_API_KEY)
end
```

### Client

`Spage::Api::Page.new.all` returns all the pages for your account
`Spage::Api::Page.new.find(id)` returns a single page
`Spage::Api::Page.new.update(id, page)` updates the page


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nulty/spage.

### Testing

The test suite should run normally. If the recorded API requests need to be updated, set an environment variable for the API key and pass the `record: :all` to the use_cassette function you want to re-record.

`VCR=1 STATUSPAGE_API_KEY=your-api-key bundle exec rspec`

## Roadmap

- Add a logger with null logging
- Add url_encoded body option to configuration
- Validations on the resources
- Respect HTTP caching like [`faraday/http_cache`](https://github.com/sourcelevel/faraday-http-cache)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
