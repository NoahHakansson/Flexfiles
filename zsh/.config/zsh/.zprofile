# macOS /etc/zprofile runs path_helper, which moves /usr/local/bin (an old
# python.org 3.11 without our packages) ahead of the PATH from zsh-exports.
# Put conda base Python back in front for agent login shells (Codex: zsh -lc).
[[ -o interactive ]] || export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
