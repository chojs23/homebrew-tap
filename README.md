# homebrew tap

## How do I install these formulae?

`brew install chojs23/tap/ec`

Or `brew tap chojs23/tap` and then `brew install ec`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "chojs23/tap"
brew "ec"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Adding more formulae

Place each new formula in `Formula/` as its own `*.rb` file. Homebrew will make every formula in this tap installable.
