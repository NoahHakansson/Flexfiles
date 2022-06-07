# Flexfiles

My Dotfiles.

Feel free to use/steal anything 🙂

Features:

- The fast and powerful [Alacritty](https://github.com/alacritty/alacritty) terminal emulator with a onedark inspired theme.
- Standalone Zshrc, (No Oh My Zsh!). With vim mode, [fzf](https://github.com/junegunn/fzf), tab completion powered with [fzf-tab](https://github.com/Aloxaf/fzf-tab) and a nice looking prompt with git integration.
- Tmux with sane keybindings, automatic session saving and restoring on reboot and the same onedark inspired theme.
- [Zathura](https://pwmt.org/projects/zathura/) a vim-like keyboard driven pdf viewer. 
- [Jet brains mono nerd font](https://github.com/ryanoasis/nerd-fonts) The best font ever made patched with a load of glyphs(icons).
- [LunarVim](https://www.lunarvim.org/) My config for LunarVim a completely lua based IDE layer for Neovim that can be easily configured and extended.

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
`Neovim (v0.7.0+), git, stow, make, pip, npm, node, fnm and cargo`

## Programs

* [Alacritty](https://github.com/alacritty/alacritty)
* [LunarVim](https://www.lunarvim.org)
* [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
* [Zathura](https://pwmt.org/projects/zathura/)

