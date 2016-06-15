# Fancy to_proc

Have you ever wished Symbol#to_proc was chainable and took arguments?

```ruby
["banana  ", " hammock!"].map &:strip&:capitalize&:gsub.(/mm/, "dd")
#=> ["Banana", "Haddock!"]
```

Well now it can!

## Methods

### & chainable ampersand

The ampersand operator is added to Symbol (and Proc) so that you can chain like so:

```ruby
["banana", "  hammock! "].map &:strip&:capitalize
#=> ["Banana", "Haddock!"]
```

Note that above the first ampersand is built into Ruby, it's the second ampersand added by this Gem.


### .() call with arguments

Yep, pass whatever arguments you like to your symbol method, very convenient!

```ruby
["banana", "hammock!"].map &:gsub.(/mm/, "dd")
#=> ["banana", "haddock!"]
```

Note the dot before the brackets, it's short for `.call()` which you can also use.


### ~ method tilde

Instead of the method being called on the yielded object, the object(s) is passed to the method. How often have you wanted to do this:

```ruby
["potato", "scrunchie"].map &~:p
#=> "potato"
#=> "scrunchie"
```

Note, this is the unary tilde, so while it comes before it is actually just a method called on Symbol.


## Experimental!

I'm not sure how I feel about these methods. They have their uses and they're not _too_ crazy, but they're still a bit unintuitive and weird. As such I'm calling them experimental and may remove / change them. Feedback please! Also note that if you're already defining any of the methods in this gem then they won't be clobbered.

### | pipe argument (Symbol)

Pass a single argument to a symbol method, slightly shorter than the above call brackets style. Specifically designed for this kind of case:

```ruby
[1, 2, 3, 4].map &:*|2
#=> [2, 4, 6, 8]
```

It returns a proc you can store and reuse (very terse):

```ruby
inc = :+|1
[1, 2, 3, 4].map &inc
#=> [2, 3, 4, 5]
```

It doesn't have to be used for maths though:

```ruby
["chocolate", "doorstop?"].map &:delete|"?"
#=> ["chocolate", "doorstop"]
```


### | pipe argument (Proc)

To be used in combination with method tilde. It curries the method and partially applies a value to it. Best see an example:

```ruby
["nougat", "lightbulb"].each_with_index.map &~:sprintf|"Tasty: %s, Option: %d"
#=> ["Tasty: nougat, Option: 0", "Tasty: lightbulb, Option: 1"]
```

The above is functionally equivalent to this:

```ruby
["nougat", "lightbulb"].each_with_index.map &method(:sprintf).curry(2)["Tasty: %s, Option: %d"]
#=> ["Tasty: nougat, Option: 0", "Tasty: lightbulb, Option: 1"]
```

The pipe syntax is weird but `.()` is already defined on Proc so I couldn't use it. I'm also not sure how often this will be useful, though I'm sure I've wanted to do something like this on occasion. 

Note that if you start chaining expressions with the pipe method in then you'll have to wrap them in brackets because the precedence of pipe isn't high enough. Another reason why these are experimental.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "fancy_to_proc"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fancy_to_proc


## RuboCop

RuboCop will complain if you don't put spaces around `&` so I've provided a monkeypatch (yay) to RuboCop's "SpaceAroundOperators" cop to ignore just the `&`.

To use project-wide require `fancy_to_proc` at the top of your `.rubocop.yml`:

```yaml
require: fancy_to_proc
```

Or to use on the command line require it with a flag:

```sh
rubocop --require fancy_to_proc
```

## Development

Run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fancy_to_proc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

(and/or open issues, your feedback welcome)
