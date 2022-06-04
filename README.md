# Flexfiles

## Installing

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
## Try it in a docker container (Not everything is available in docker)
### Important: type 'exec zsh' once to reload, otherwise zsh plugins dont work.

```bash
docker run --name testFF -e TERM -e COLORTERM -w /root -it --rm ubuntu sh -uec '
    apt update
    apt install -y sudo curl unzip zsh vim exa tmux git stow fzf
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/NoahHakansson/Flexfiles/tryme/tryme.sh)"'
```

## Tmux
Tmux needs TPM (Tmux Plugin Manager) https://github.com/tmux-plugins/tpm

## Programs (TODO)

An updated list of all the programs I use can be found in the `programs` directory
