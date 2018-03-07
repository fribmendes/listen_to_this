[listentothis]: https://reddit.com/r/listentothis
[homebrew]: https://brew.sh/
[mpv]: https://mpv.io/
[youtube-dl]: https://rg3.github.io/youtube-dl/
[issues]: https://github.com/fribmendes/listen_to_this/issues

# Listen To This

I get it. You want to go over to [/r/listentothis](listentothis) but you don't
want to leave the terminal. Maybe you're lazy. Maybe you can't 'cause you work
in an open space and your boss is always suspiciously looking over your shoulder
to see what you are up to.

Worry not. I'm here for you.

## Install

Let's cut straight to the action, shall we?

Start by cloning this repo.

```shell
git clone https://github.com/fribmendes/listen_to_this.git
cd listen_to_this
```

Now, let's install some dependencies shall we?

If you are running macOS with [Homebrew](homebrew), all you have to do is to run

```shell
bin/setup
```

Otherwise, you're going to need to install [`mpv`](mpv) and
[`youtube-dl`](youtube-dl). Once you install those, you just need to run
`bin/setup`. See? Easy.

## Running

```shell
ruby app/app.rb
```

will do the trick. For now. I'll turn this into something user-friendlier later on.

## Contributing

Feel free to contribute. You can also just [open an issue](issues) if you want
to. Or make a pull request, whatever you prefer.

Here's one of them TODO lists to help you out if you want to do something.

### TODOs

- [ ] find a friendlier, more `$PATH`-y way to run this than `ruby app/app.rb`
- [ ] filter songs by style (i wonder if i can stick ai into this, with all
  those different genres)
- [ ] add pause, next and previous CLI controls
- [ ] prompt for next page once the songs end
