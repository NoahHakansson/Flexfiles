# Flexfiles

My Dotfiles.

Feel free to use/steal anything 🙂

## Table of Contents

- [Installation](#Installation)
- [Wayland fixes](#wayland-fixes)
- [Programs](#Programs)

## Installation

You will need `git` and GNU `stow`

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/NoahHakansson/Flexfiles.git ~
```

Run `stow` to symlink everything or just select what you want

```bash
stow */ # Everything (the '/' ignores the README)
```

```bash
stow zsh # Just my zsh config
```

## Wayland fixes

### brave-browser (should work on chromium based browsers)

Go to `brave://flags/` search for ozone and change the setting to `auto`.
Close and relaunch the app fully (not the relaunch button). Should be fine after that.

### slack

To fix screen sharing on Wayland start slack with `--enable-features=WebRTCPipeWireCapturer` flag.

```
slack --enable-features=WebRTCPipeWireCapturer
```

### rust ~/.cargo/env

```bash
#!/bin/sh
# rustup shell setup
# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
    *:"$HOME/.cargo/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
        export PATH="$HOME/.cargo/bin:$PATH"
        ;;
esac
```

## Programs

A non-exhaustive list of programs that I use.

- [Alacritty](https://github.com/alacritty/alacritty)
- [LunarVim](https://www.lunarvim.org)
- [Neovim](https://neovim.io/)
- [Zathura](https://pwmt.org/projects/zathura/)
- [gofumpt (stricter gofmt)](https://github.com/mvdan/gofumpt)
- [Tmux](https://github.com/tmux/tmux)
- [Bear](https://github.com/rizsotto/Bear)
- [Bismuth](https://github.com/Bismuth-Forge/bismuth)
- [patat](https://github.com/jaspervdj/patat)
- [fzf](https://github.com/junegunn/fzf)
- [sway](https://swaywm.org/)
- [swayr](https://sr.ht/~tsdh/swayr/)
- [waybar](https://github.com/Alexays/Waybar)
- [autotiling-rs](https://github.com/ammgws/autotiling-rs)
- [mako](https://github.com/emersion/mako)
- [WebCord](https://github.com/SpacingBat3/WebCord)
- brave-browser
- playerctl
- wofi
- dmenu
- nmcli
- git
- stow
- make
- pip
- npm
- node
- [fnm](https://github.com/Schniz/fnm)
- cargo
