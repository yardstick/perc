# Perc

Perc is a "microframework" for bootstrapping small ruby apps that are not really web apps so Sinatra and rails aren't quite what you want.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'perc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install perc

## Usage

We don't have initializers yet so setup a new ruby app like in `template_app/`

But we do have `thor` already so feel free to help out by making a `perc new` command.

The money is in `config/application.rb`. But this is a microframework so you have to decide how you want your app to boot.

After the `require_relative 'environment'` just add commands like:

```ruby
Perc.app.commands do |c|
  c.desc 'sidekiq', 'start the workers'
  c.command :sidekiq do
    require 'sidekiq/cli'
    cli = Sidekiq::CLI.instance
    cli.run
  end
end
```

As you can see perc is mostly a box to put your other toys in. Easy to spin up, merge together any old other gem and have a microservice without the rails overhead. Of course you can always mix in rack as well if you want to do some basic web hosting.

```ruby
c.command :web do |*args|
  require 'rack'
  ARGV.shift
  Rack::Server.new.start
end
```

This will mount whatever you have setup up in `config.ru`.

You can run these commands via the perc root command. e.g.

* `perc web` will boot your rack up configed above.
* `perc sidekiq` will run your sidekiq workers as you defined them in the command above.
* `perc console` comes with perc. Loads an irb session with your app context fully loaded.
* `perc help` display all commands defined for your perc app.

Of course the perc command builder is just a wrapper for [thor](https://github.com/erikhuda/thor). Default commands found [here](https://github.com/yardstick/perc/blob/master/lib/perc/cli.rb).

Some other useful things:

Everything in initializers gets booted by everything defined in your `Perc.app.commands` collection. (Similar to rails initializers)

There's a `config_for` helper on `Perc.app`. Works similar to the [rails method](https://apidock.com/rails/Rails/Application/config_for). Looks for YAML files in the config directory.

perc is basically a super light version of rails. The project directories are similar enough it should be pretty easy to convert a perc app to a rails app. Or include perc in a rails app for setting up custom commands very easily (might be some conflict with loading config/application.rb... this idea probably needs work)

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yardstick/perc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
