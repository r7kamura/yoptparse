# Yoptparse

[![Gem Version](https://badge.fury.io/rb/yoptparse.svg)](https://badge.fury.io/rb/yoptparse)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/r7kamura/yoptparse)
[![CircleCI](https://circleci.com/gh/r7kamura/yoptparse.svg?style=svg)](https://circleci.com/gh/r7kamura/yoptparse)

Command line option parsing with [YARD](http://yardoc.org/) and optparse.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "yoptparse"
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install yoptparse
```

## Usage

Inherit `Yoptparse::Command` and define `#initialize` method with YARD style documentation.

```ruby
class ExampleCommand < Yoptparse::Command
  # Usage example-command [options]
  # @param destination [String] Directory path to put extracted emoji images
  # @param format [String] png or svg (default: png)
  # @param provider [String] Emoji provider name (apple, emoji_one, noto or twemoji)
  # @param quiet [Boolean] Disable log output
  # @param size [Integer] Image size
  def initialize(destination:, format: "png", provider:, quiet: false, size: 64)
    @destination = destination
    @format = format
    @provider = provider
    @quiet = quiet
    @size = size
  end
end
```

### Yoptparse::Command.to_option_parser

Returns an `OptionParser` instance.

```ruby
puts ExampleCommand.to_option_parser
```

```
Usage: example-command [options]
        --destination=               Directory path to put extracted emoji images (required)
        --provider=                  Emoji provider name (apple, emoji_one, noto or twemoji) (required)
        --format=                    png or svg (default: png)
        --quiet                      Disable log output
        --size=                      Image size
```

### Yoptparse::Command.parse

Create a new instance from ARGV parse result.

```ruby
p ExampleCommand.parse(ARGV)
```

```
#<ExampleCommand:0x007ff6e41b8ea0 @destination="/path/to/emoji", @format="png", @provider="twemoji", @quiet=false, @size=64>
```

### Documentation

See API documentation at http://www.rubydoc.info/github/r7kamura/yoptparse.
