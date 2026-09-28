# Maintaining Flexfiles

This repository holds dotfiles managed with GNU Stow. Preview changes with `stow --simulate` before applying a package, and preserve unrelated packages and local edits. Stateful application directories must remain real directories; do not let Stow replace them wholesale with links.

Global agent instructions, personal skills and machine operations are maintained separately in fleet. Do not add an agent configuration package here.
