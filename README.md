# Parser

Simple ruby parser gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'parser', git: 'https://github.com/dgrebenyuk/parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone git@github.com:dgrebenyuk/parser.git
    $ cd ./parser
    $ gem build parser.gemspec
    $ gem install parser-0.1.0

## Usage

```ruby
api_resp = <<-EOT
    Events[0].Lane=1
    Events[0].Country=USA
    Events[0].Object.BoundingBox[0]=1248
    Events[0].Object.BoundingBox[1]=3528
    Events[0].Object.BoundingBox[2]=1920
    Events[0].Object.BoundingBox[3]=3848
EOT
hash = Parser.proceed(api_resp) # "Lane"=>1, "Country"=>"USA", "Object"=>{"BoundingBox"=>[1248, 3528, 1920, 3848]}}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## RSpec

Current functionality is covered by rspec tests. Just clone gem code from git and then run:

    $ bundle
    $ rspec
    ...
    Finished in 0.01094 seconds (files took 0.18907 seconds to load)
    4 examples, 0 failures

## Knowing Issues

Gem works only with provided structure of incoming parameter. It doesn't cover next cases:

1) First level arrays (e.g `Events[0].Data[0]`)
2) Nested elements more then 2 levels deep (e.g. `Events[0].Book.Attrs.Title=Ruby for Dummies`)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dgrebenyuk/parser.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
