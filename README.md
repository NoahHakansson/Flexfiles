# Flexfiles

My Dotfiles.

Feel free to use/steal anything 🙂

Features:

- The fast and powerful [Alacritty](https://github.com/alacritty/alacritty) terminal emulator with a onedark inspired theme.
- Standalone Zshrc, (No Oh My Zsh!). With vim mode, [fzf](https://github.com/junegunn/fzf), tab completion powered by [fzf-tab](https://github.com/Aloxaf/fzf-tab) and a nice looking prompt with git integration.
- Tmux with sane keybindings, automatic session saving and restoring on reboot using [TPM](https://github.com/tmux-plugins/tpm) for plugins and the same onedark inspired theme.
- [LunarVim](https://www.lunarvim.org/) My config for LunarVim a completely lua based IDE layer for Neovim that can be easily configured and extended.
- [Zathura](https://pwmt.org/projects/zathura/) a vim-like keyboard driven pdf viewer. 
- [Jet brains mono nerd font](https://github.com/ryanoasis/nerd-fonts) The best font ever made patched with a load of glyphs(icons).

![Flexfiles image 1](./Flexfiles-1.png)
![Flexfiles image 2](./Flexfiles-2.png)

## Table of Contents

- [Installation](#Installation)
- [Requirements](#Requirements)
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

## Requirements

Make sure you have installed:
`Neovim (v0.7.0+), LunarVim, git, stow, fzf, make, pip, npm, node, fnm and cargo`

## Programs

A non-exhaustive list of programs that I use.

- [Alacritty](https://github.com/alacritty/alacritty)
- [LunarVim](https://www.lunarvim.org)
- [Neovim](https://neovim.io/)
- [Zathura](https://pwmt.org/projects/zathura/)
- [Tmux](https://github.com/tmux/tmux)
- [Bear](https://github.com/rizsotto/Bear)
- [Bismuth](https://github.com/Bismuth-Forge/bismuth)
- [patat](https://github.com/jaspervdj/patat)
- [fzf](https://github.com/junegunn/fzf)
- git
- stow
- make
- pip
- npm
- node
- fnm
- cargo


