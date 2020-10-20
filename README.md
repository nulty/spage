# Spage

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/spage`. To experiment with that code, 

TODO: Delete this and the text above, and describe your gem

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

`Spage::Api::Page.all` returns all the pages for your account
`Spage::Api::Page.find(id)` returns a single page
`Spage::Api::Page.update(id, page)` updates the page


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nulty/spage.

### Testing

The test suite should run normally. If the recorded API requests need to be updated, set an environment variable for the API key

`STATUSPAGE_API_KEY=your-api-key bundle exec rspec`

## Roadmap

- Add a logger with null logging
- Add url_encoded body option to configuration

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
