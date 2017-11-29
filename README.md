# Telegrator


## Installation

Telegrator only comes as a CLI application. To install it run:

    $ gem install telegrator


## Usage

You can easily set up a new bot project:

    $ telegrator new foo_bot

This will generate a skeleton like this:
```
foo_bot/
|__ app/
    |__ commands/
    |__ keyboards/
    |__ models/
    |__ services/
    |__ workers/
    |__ commands.rb
    |__ keyboards.rb
    |__ models.rb
    |__ services.rb
    |__ workers.rb
|__ bin/
    |__ bot
|__ config/
    |__ boot.rb
    |__ initializers/
        |__ ...
|__ log/
    |__ .keep
|__ Gemfile
|__ Rakefile
```


## Contributing

Bug reports and pull requests are welcome.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

